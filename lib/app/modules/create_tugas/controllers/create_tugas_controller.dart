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
  var db = FirebaseFirestore.instance;

  void createTask() {
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
