import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

List<Map<String, dynamic>> specTask = [];
final box = GetStorage();
var db = FirebaseFirestore.instance;

bool isLoading = true;

Future<void> getSpecTask() async {
  specTask.clear();

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

    await insertSpecTask(specTask);

    isLoading = false;
  } catch (e) {
    debugPrint('Error inserting specs: $e');
  }
}

Future<void> insertSpecTask(List<Map<String, dynamic>> specTaskData) async {
  await box.remove('specTask');

  await box.write('specTask', specTaskData);

  return;
}
