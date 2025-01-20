import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reminder_tugas/app/helper/spec.dart' as helper;

class CategoryController extends GetxController {
  var db = FirebaseFirestore.instance;

  TextEditingController category = TextEditingController();
  Rxn<String> errorCategory = Rxn<String>(null);
  bool validateCategory() {
    if (category.text.isEmpty) {
      errorCategory.value = 'Kategori harus diisi';

      return false;
    } else {
      errorCategory.value = null;

      return true;
    }
  }

  Rxn<Map<String, dynamic>> jenis = Rxn<Map<String, dynamic>>(null);
  Rxn<String> errorJenis = Rxn<String>(null);
  bool validateJenis() {
    if (jenis.value == null) {
      errorJenis.value = 'Jenis tugas harus dipilih';

      return false;
    } else {
      errorJenis.value = null;

      return true;
    }
  }

  Future<void> addSpecTask() async {
    debugPrint('addSpecTask');

    var docId = jenis.value!['code'];
    var dataNew = {
      'title': category.text.trim(),
      'code': category.text.trim().toLowerCase().replaceAll(' ', '_')
    };

    final docSnapshot = await db.collection('specs').doc(docId).get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      final keys = data.keys.map((key) => int.tryParse(key) ?? -1).toList();
      final newKey =
          (keys.isEmpty ? 0 : keys.reduce((a, b) => a > b ? a : b) + 1)
              .toString();

      await db.collection('specs').doc(docId).update({
        newKey: dataNew,
      });

      await addSpecFromStorage(docId, dataNew);
      await helper.getSpecTask();

      debugPrint("Data added with key: $newKey");
    } else {
      debugPrint("Document $docId does not exist.");
    }
  }

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

  Future<String?> getSpecKey(String docId, String dataValue) async {
    try {
      DocumentSnapshot doc = await db.collection('specs').doc(docId).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        var resultID = data.keys.firstWhere(
          (key) => data[key]['code'] == dataValue,
        );

        return resultID;
      } else {
        debugPrint("Document does not exist.");
        return null;
      }
    } catch (e) {
      debugPrint("Error getting document: $e");
      return null;
    }
  }

  Future<void> deleteSpec(String id, String data) async {
    try {
      String? dataId = await getSpecKey(id, data);

      if (dataId != null) {
        await FirebaseFirestore.instance.collection('specs').doc(id).update({
          dataId: FieldValue.delete(),
        });
        debugPrint("Key $dataId deleted successfully!");
      } else {
        debugPrint("Invalid key: $dataId");
      }

      await deleteSpecFromStorage(id, data);
      await helper.getSpecTask();

      getSpecTask();
    } catch (e) {
      debugPrint('Error updating spec: $e');
    }
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
