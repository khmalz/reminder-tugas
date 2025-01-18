import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

class UpdateTugasController extends GetxController {
  Task task = Task.fromJson(Get.arguments);

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

  final box = GetStorage();
  List<Map<String, dynamic>> specName = [];
  List<Map<String, dynamic>> specType = [];
  List<Map<String, dynamic>> specCollection = [];

  Future<void> getSpecTask() async {
    Map<String, dynamic> specTask = await box.read('specTask')[0];

    specName = specTask['name'];
    specType = specTask['type'];
    specCollection = specTask['collection'];
  }

  var db = FirebaseFirestore.instance;
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

  bool validateMatkul() {
    if (matkul.text.isEmpty) {
      errorMatkul.value = 'Mata kuliah harus diisi';

      return false;
    } else {
      errorMatkul.value = null;

      return true;
    }
  }

  bool validateJenis() {
    if (jenisTugas.value == null) {
      errorJenis.value = 'Jenis tugas harus dipilih';

      return false;
    } else {
      errorJenis.value = null;

      return true;
    }
  }

  bool validateTipe() {
    if (tipeTugas.value == null) {
      errorTipe.value = 'Tipe tugas harus dipilih';

      return false;
    } else {
      errorTipe.value = null;

      return true;
    }
  }

  bool validatePengumpulan() {
    if (pengumpulan.value == null) {
      errorPengumpulan.value = 'Pengumpulan harus dipilih';

      return false;
    } else {
      errorPengumpulan.value = null;

      return true;
    }
  }

  bool validateDeadline() {
    if (deadline.text.isEmpty) {
      errorDeadline.value = 'Deadline harus diisi';

      return false;
    } else {
      errorDeadline.value = null;

      return true;
    }
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

  Future<void> updateTask() async {
    if (!hasInputChanged()) {
      Get.rawSnackbar(
        message: 'Tugas belum ada yang berubah.',
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
      Get.rawSnackbar(
        message: 'Kamu harus mengisi semua form terlebih dahulu.',
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );

      return;
    }

    try {
      var taskData = {
        'name': jenisTugas.value!['title'],
        'matkul': matkul.text.trim(),
        'type': tipeTugas.value!['title'],
        'collection': pengumpulan.value!['title'],
        'deadline': Timestamp.fromDate(dates[0]!),
        'is_done': false,
      };

      await db.collection("tasks").doc(task.id).update(taskData);

      debugPrint('Task updated successfully');

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.rawSnackbar(
        message: e.toString(),
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );

      debugPrint('Error updating task: $e');
    }
  }
}
