import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:reminder_tugas/app/data/constant/talker.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'package:reminder_tugas/app/data/provider/logging_provider.dart';
import 'package:reminder_tugas/app/helper/id_generator.dart';
import 'package:reminder_tugas/app/helper/validate_input.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';
import 'package:talker_flutter/talker_flutter.dart' show Talker;

class CreateTugasController extends GetxController {
  // LOGGING
  final Talker talker = LoggingProvider.talker;

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
          'Mata kuliah harus diisi',
        ),
        MapEntry(
          (value) => value != null && value.length <= 100,
          'Mata kuliah tidak boleh lebih dari 100 karakter',
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
          'Jenis tugas harus dipilih',
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
          'Tipe tugas harus dipilih',
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
          'Pengumpulan harus dipilih',
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
          'Deadline harus diisi',
        ),
        MapEntry(
          (value) => value != null && value.length <= 100,
          'Deadline tidak boleh lebih dari 100 karakter',
        ),
      ],
    );
  }

  // STORAGE
  RxList<Map<String, dynamic>> specName = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specType = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specCollection = <Map<String, dynamic>>[].obs;

  Future<void> getSpecTask() async {
    final specBox = await Hive.openBox('specs');

    specName.value = (specBox.get('name') as List<dynamic>?)
            ?.map((e) => Map<String, dynamic>.from(e))
            .toList() ??
        [];

    specType.value = (specBox.get('type') as List<dynamic>?)
            ?.map((e) => Map<String, dynamic>.from(e))
            .toList() ??
        [];

    specCollection.value = (specBox.get('collection') as List<dynamic>?)
            ?.map((e) => Map<String, dynamic>.from(e))
            .toList() ??
        [];
  }

  @override
  void onInit() async {
    super.onInit();
    getSpecTask();
  }

  Future<void> createTask() async {
    bool isValidate = true;

    isValidate &= validateMatkul();
    isValidate &= validateJenis();
    isValidate &= validateTipe();
    isValidate &= validatePengumpulan();
    isValidate &= validateDeadline();

    if (!isValidate) {
      Get.rawSnackbar(
        message: 'Kamu harus mengisi semua form terlebih dahulu.',
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );

      return;
    }

    var taskData = {
      'id': idGenerator(),
      'name': jenisTugas.value!['title'],
      'matkul': matkul.text,
      'type': tipeTugas.value!['title'],
      'collection': pengumpulan.value!['title'],
      'deadline': deadline.text,
      'is_done': false,
    };

    try {
      final box = await Hive.openBox<Task>('main');
      box.add(Task.fromJson(taskData));

      // debugPrint('Task created successfully');
      talker.logCustom(LogGood('Task created successfully'));

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      debugPrint('Error creating task: $e');
    }
  }
}
