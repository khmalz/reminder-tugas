import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reminder_tugas/app/helper/spec.dart' as helper;

class CategoryController extends GetxController {
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

  var db = FirebaseFirestore.instance;

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
