import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:reminder_tugas/app/helper/validate_input.dart';

class CategoryController extends GetxController {
  // VALIDATION
  TextEditingController title = TextEditingController();
  Rxn<Map<String, dynamic>> jenis = Rxn<Map<String, dynamic>>(null);

  Rxn<String> errorTitle = Rxn<String>(null);
  Rxn<String> errorJenis = Rxn<String>(null);

  bool validateTitle() {
    return validateInput<String>(
      value: title.text,
      setError: (msg) => errorTitle.value = msg,
      validatorsWithMessages: [
        MapEntry(
          (value) => value != null && value.isNotEmpty,
          'Kategori harus diisi',
        ),
        MapEntry(
          (value) => value != null && value.length <= 20,
          'Kategori tidak boleh lebih dari 20 karakter',
        ),
      ],
    );
  }

  bool validateJenis() {
    return validateInput<Map<String, dynamic>>(
      value: jenis.value,
      setError: (msg) => errorJenis.value = msg,
      validatorsWithMessages: [
        MapEntry(
          (value) => value != null,
          'Jenis tugas harus dipilih',
        ),
      ],
    );
  }

  void clearInput() {
    title.clear();
    jenis.value = null;
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

  Future<void> addSpecTask() async {
    bool isValidate = true;

    isValidate &= validateTitle();
    isValidate &= validateJenis();

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
      var category = jenis.value!['code'];
      Map<String, dynamic> dataNew = {
        'title': title.text.trim(),
        'code': title.text.trim().toLowerCase().replaceAll(' ', '_'),
      };

      final specBox = await Hive.openBox('specs');

      List<Map<String, dynamic>> specList =
          (specBox.get(category, defaultValue: []) as List)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();

      specList.add(Map<String, dynamic>.from(dataNew));

      await specBox.put(category, specList);

      await getSpecTask();

      clearInput();
      debugPrint("Data added successfully to document: $category");
    } catch (e) {
      debugPrint("Error adding spec: $e");
    }
  }

  Future<void> deleteSpec(String category, String code) async {
    try {
      final specBox = await Hive.openBox('specs');

      List<Map<String, dynamic>> specList =
          (specBox.get(category, defaultValue: []) as List)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();

      specList.removeWhere((spec) => spec['code'] == code);
      await specBox.put(category, specList);

      await getSpecTask();
      debugPrint(
          'Data dengan code $code berhasil dihapus dari kategori $category');
    } catch (e) {
      debugPrint('Error deleting spec: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getSpecTask();
  }
}
