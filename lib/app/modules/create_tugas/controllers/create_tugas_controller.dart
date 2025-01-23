import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'package:reminder_tugas/app/helper/id_generator.dart';
import 'package:reminder_tugas/app/helper/validate_input.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

class CreateTugasController extends GetxController {
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
      errorMessage: 'Mata kuliah harus diisi',
      validator: (value) => value != null && value.isNotEmpty,
    );
  }

  bool validateJenis() {
    return validateInput<Map<String, dynamic>>(
      value: jenisTugas.value,
      setError: (msg) => errorJenis.value = msg,
      errorMessage: 'Jenis tugas harus dipilih',
      validator: (value) => value != null,
    );
  }

  bool validateTipe() {
    return validateInput<Map<String, dynamic>>(
      value: tipeTugas.value,
      setError: (msg) => errorTipe.value = msg,
      errorMessage: 'Tipe tugas harus dipilih',
      validator: (value) => value != null,
    );
  }

  bool validatePengumpulan() {
    return validateInput<Map<String, dynamic>>(
      value: pengumpulan.value,
      setError: (msg) => errorPengumpulan.value = msg,
      errorMessage: 'Pengumpulan harus dipilih',
      validator: (value) => value != null,
    );
  }

  bool validateDeadline() {
    return validateInput<String>(
      value: deadline.text,
      setError: (msg) => errorDeadline.value = msg,
      errorMessage: 'Deadline harus diisi',
      validator: (value) => value != null && value.isNotEmpty,
    );
  }

  // STORAGE
  final box = GetStorage();
  List<Map<String, dynamic>> specName = [];
  List<Map<String, dynamic>> specType = [];
  List<Map<String, dynamic>> specCollection = [];

  void getSpecTask() {
    Map<String, dynamic> specTask = box.read('specTask')[0];

    specName = List<Map<String, dynamic>>.from(specTask['name']);
    specType = List<Map<String, dynamic>>.from(specTask['type']);
    specCollection = List<Map<String, dynamic>>.from(specTask['collection']);
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

      debugPrint('Task created successfully');

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      debugPrint('Error creating task: $e');
    }
  }
}
