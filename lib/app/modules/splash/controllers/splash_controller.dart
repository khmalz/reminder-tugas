import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

class SplashController extends GetxController {
  List<Map<String, dynamic>> specTask = [];
  final box = GetStorage();
  var db = FirebaseFirestore.instance;

  bool isLoading = true;

  Future<void> getSpecTask() async {
    await box.erase();

    List<Map<String, dynamic>> specName = [];
    List<Map<String, dynamic>> specType = [];
    List<Map<String, dynamic>> specCollection = [];

    try {
      var snapshot = await FirebaseFirestore.instance.collection('specs').get();

      for (var doc in snapshot.docs) {
        var data = doc.data();

        if (doc.id == "name") {
          for (var item in data.values) {
            specName.add(Map<String, dynamic>.from(item));
          }
        }

        if (doc.id == "type") {
          for (var item in data.values) {
            specType.add(Map<String, dynamic>.from(item));
          }
        }
        if (doc.id == "collection") {
          for (var item in data.values) {
            specCollection.add(Map<String, dynamic>.from(item));
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching specs: $e');
    }

    try {
      specTask.add(
          {'name': specName, 'type': specType, 'collection': specCollection});

      insertSpecTask(specTask);

      isLoading = false;
    } catch (e) {
      debugPrint('Error inserting specs: $e');
    }
  }

  void insertSpecTask(List<Map<String, dynamic>> specTask) async {
    await box.write('specTask', specTask);

    debugPrint('Spec task inserted successfully');

    return;
  }

  @override
  void onInit() async {
    super.onInit();
    await getSpecTask();

    if (!isLoading) Get.offAllNamed(Routes.HOME);
  }
}
