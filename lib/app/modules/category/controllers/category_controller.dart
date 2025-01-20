import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reminder_tugas/app/data/provider/spec_task_provider.dart';
import 'package:reminder_tugas/app/helper/spec.dart' as helper;

class CategoryController extends GetxController {
  // VALIDATION
  TextEditingController category = TextEditingController();
  Rxn<Map<String, dynamic>> jenis = Rxn<Map<String, dynamic>>(null);

  Rxn<String> errorCategory = Rxn<String>(null);
  Rxn<String> errorJenis = Rxn<String>(null);

  bool validateCategory() {
    if (category.text.isEmpty) {
      errorCategory.value = 'Kategori harus diisi';

      return false;
    } else {
      errorCategory.value = null;

      return true;
    }
  }

  bool validateJenis() {
    if (jenis.value == null) {
      errorJenis.value = 'Jenis tugas harus dipilih';

      return false;
    } else {
      errorJenis.value = null;

      return true;
    }
  }

  // Firebase
  SpecTaskProvider specTaskProvider = SpecTaskProvider();

  Future<void> addSpecTask() async {
    try {
      var docId = jenis.value!['code'];
      var dataNew = {
        'title': category.text.trim(),
        'code': category.text.trim().toLowerCase().replaceAll(' ', '_'),
      };

      await specTaskProvider.addSpec(docId, dataNew);

      await addSpecFromStorage(docId, dataNew);
      await helper.getSpecTask();

      clearInput();
      debugPrint("Data added successfully to document: $docId");
    } catch (e) {
      debugPrint("Error adding spec: $e");
    }
  }

  Future<String?> getSpecKey(String docId, String dataValue) async {
    try {
      String? resultID = await specTaskProvider.getSpecKey(docId, dataValue);

      if (resultID == null) {
        debugPrint("Error getting document");
      } else if (resultID.isEmpty) {
        debugPrint("Document doesn't exist");
      }

      return resultID;
    } catch (e) {
      debugPrint("Error in controller: $e");
      return null;
    }
  }

  Future<void> deleteSpec(String id, String data) async {
    try {
      String? dataId = await getSpecKey(id, data);

      if (dataId != null) {
        await specTaskProvider.deleteSpec(id, dataId);

        debugPrint("Key $dataId deleted successfully!");
      } else {
        debugPrint("Error deleting key $dataId");
      }

      await deleteSpecFromStorage(id, data);
      await helper.getSpecTask();

      getSpecTask();
    } catch (e) {
      debugPrint("Error deleting spec: $e");
    }
  }

  void clearInput() {
    category.clear();
    jenis.value = null;
  }

  // STORAGE
  final box = GetStorage();
  RxList<Map<String, dynamic>> specName = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specType = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specCollection = <Map<String, dynamic>>[].obs;

  void getSpecTask() async {
    var specTask = await box.read('specTask')[0];

    specName.value = List<Map<String, dynamic>>.from(specTask['name']);
    specType.value = List<Map<String, dynamic>>.from(specTask['type']);
    specCollection.value =
        List<Map<String, dynamic>>.from(specTask['collection']);
  }

  Future<void> addSpecFromStorage(String id, Map<String, dynamic> data) async {
    try {
      switch (id) {
        case "name":
          specName.add(data);
          break;
        case "type":
          specType.add(data);
          break;
        case "collection":
          specCollection.add(data);
          break;
        default:
          break;
      }
    } catch (e) {
      debugPrint('Error updating spec: $e');
    }
  }

  Future<void> deleteSpecFromStorage(String id, String data) async {
    try {
      switch (id) {
        case "name":
          specName.removeWhere((item) => item['code'] == data);
          break;
        case "type":
          specType.removeWhere((item) => item['code'] == data);
          break;
        case "collection":
          specCollection.removeWhere((item) => item['code'] == data);
          break;
        default:
          break;
      }
    } catch (e) {
      debugPrint('Error updating spec: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getSpecTask();
  }
}
