import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:reminder_tugas/app/data/constant/talker.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'package:reminder_tugas/app/data/provider/logging_provider.dart';
import 'package:reminder_tugas/app/helper/sorted_list_box.dart';
import 'package:reminder_tugas/app/helper/validate_input.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';
import 'package:talker_flutter/talker_flutter.dart';

class UpdateTugasController extends GetxController {
  final Talker talker = LoggingProvider.talker;
  Task task = Task.fromJson(Get.arguments);

  // VALIDATION
  Rxn<Map<String, dynamic>> jenisTugas = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> tipeTugas = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> pengumpulan = Rxn<Map<String, dynamic>>(null);
  var dates = <DateTime?>[].obs;

  final TextEditingController matkul = TextEditingController();
  final TextEditingController deadline = TextEditingController();
  Rxn<String> errorMatkul = Rxn<String>(null);
  Rxn<String> errorJenis = Rxn<String>(null);
  Rxn<String> errorTipe = Rxn<String>(null);
  Rxn<String> errorPengumpulan = Rxn<String>(null);
  Rxn<String> errorDeadline = Rxn<String>(null);

  bool validateMatkul() {
    return validateInput<String>(
      value: matkul.text,
      setError: (msg) => errorMatkul.value = msg,
      validatorsWithMessages: [
        MapEntry(
          (value) => value != null && value.isNotEmpty,
          'Harus diisi',
        ),
        MapEntry(
          (value) => value != null && value.length <= 20,
          'Maksimal 20 karakter',
        ),
      ],
    );
  }

  bool validateJenis() {
    return validateInput<Map<String, dynamic>>(
      value: jenisTugas.value,
      setError: (msg) => errorJenis.value = msg,
      validatorsWithMessages: [
        MapEntry(
          (value) => value != null,
          'Harus dipilih',
        ),
      ],
    );
  }

  bool validateTipe() {
    return validateInput<Map<String, dynamic>>(
      value: tipeTugas.value,
      setError: (msg) => errorTipe.value = msg,
      validatorsWithMessages: [
        MapEntry(
          (value) => value != null,
          'Harus dipilih',
        ),
      ],
    );
  }

  bool validatePengumpulan() {
    return validateInput<Map<String, dynamic>>(
      value: pengumpulan.value,
      setError: (msg) => errorPengumpulan.value = msg,
      validatorsWithMessages: [
        MapEntry(
          (value) => value != null,
          'Harus dipilih',
        ),
      ],
    );
  }

  bool validateDeadline() {
    return validateInput<String>(
      value: deadline.text,
      setError: (msg) => errorDeadline.value = msg,
      validatorsWithMessages: [
        MapEntry(
          (value) => value != null && value.isNotEmpty,
          'Harus diisi',
        ),
        MapEntry(
          (value) => value != null && value.length <= 30,
          'Maksimal 30 karakter',
        ),
      ],
    );
  }

  bool hasInputChanged() {
    return matkul.text != task.matkul ||
        jenisTugas.value !=
            specName.firstWhere((element) => element['title'] == task.name) ||
        tipeTugas.value !=
            specType.firstWhere((element) => element['title'] == task.type) ||
        pengumpulan.value !=
            specCollection
                .firstWhere((element) => element['title'] == task.collection) ||
        deadline.text != task.deadline;
  }

  // STORAGE
  RxList<Map<String, dynamic>> specName = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specType = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specCollection = <Map<String, dynamic>>[].obs;

  Future<void> getSpecTask() async {
    final specBox = await Hive.openBox('specs');

    specName.value = getSortedList(specBox, 'name');
    specType.value = getSortedList(specBox, 'type');
    specCollection.value = getSortedList(specBox, 'collection');
  }

  void updateInput() {
    matkul.text = task.matkul!;
    jenisTugas.value =
        specName.firstWhere((element) => element['title'] == task.name);
    tipeTugas.value =
        specType.firstWhere((element) => element['title'] == task.type);
    pengumpulan.value = specCollection
        .firstWhere((element) => element['title'] == task.collection);
    deadline.text = task.deadline!;
    dates.value = [DateFormat('dd MMMM yyyy').parse(task.deadline!)];
  }

  @override
  void onInit() async {
    super.onInit();
    await getSpecTask();

    updateInput();
  }

  Future<void> updateTask() async {
    if (!hasInputChanged()) {
      talker.warning('Belum ada yang berubah.');
      Get.rawSnackbar(
        message: 'Belum ada yang berubah.',
        backgroundColor: Colors.amber.shade800,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );

      return;
    }

    bool isValidate = true;

    isValidate &= validateMatkul();
    isValidate &= validateJenis();
    isValidate &= validateTipe();
    isValidate &= validatePengumpulan();
    isValidate &= validateDeadline();

    if (!isValidate) {
      talker.warning('Semua form harus diisi');
      Get.rawSnackbar(
        message: 'Semua form harus diisi',
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );

      return;
    }

    try {
      var taskData = {
        'id': task.id,
        'name': jenisTugas.value!['title'],
        'matkul': matkul.text.trim(),
        'type': tipeTugas.value!['title'],
        'collection': pengumpulan.value!['title'],
        'deadline': deadline.text,
        'is_done': task.isDone,
      };

      final box = await Hive.openBox<Task>('main');
      final key =
          box.keys.firstWhere((key) => box.get(key)!.id == taskData['id']);
      Task taskUpdate = Task.fromJson(taskData);
      await box.put(key, taskUpdate);

      talker.logCustom(LogGood('Task updated successfully'));

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.rawSnackbar(
        message: "Failed to update task: ${e.toString()}",
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );

      talker.error("Error updating task: $e");
    }
  }
}
