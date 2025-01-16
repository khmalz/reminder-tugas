import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

class CreateTugasController extends GetxController {
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

  var db = FirebaseFirestore.instance;

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

  void createTask() {
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
      'name': jenisTugas.value!['title'],
      'matkul': matkul.text,
      'type': tipeTugas.value!['title'],
      'collection': pengumpulan.value!['title'],
      'deadline': Timestamp.fromDate(dates[0]!),
      'is_done': false,
    };

    try {
      db.collection("tasks").add(taskData);

      debugPrint('Task created successfully');

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      debugPrint('Error creating task: $e');
    }
  }
}
