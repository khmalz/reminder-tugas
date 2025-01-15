import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/spec_tugas.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';

class UpdateTugasController extends GetxController {
  Task task = Task.fromJson(Get.arguments);

  Rxn<Map<String, dynamic>> jenisTugas = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> tipeTugas = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> pengumpulan = Rxn<Map<String, dynamic>>(null);
  var dates = <DateTime?>[].obs;

  final TextEditingController matkul = TextEditingController();
  final TextEditingController deadline = TextEditingController();
  Rxn<String> errorMatkul = Rxn<String>(null);

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
  }

  @override
  void onInit() {
    super.onInit();
    updateInput();
  }

  Future<void> updateTask() async {
    try {
      await db.collection("tasks").doc(task.id).update({
        'name': task.name,
        'matkul': task.matkul,
        'type': task.type,
        'collection': task.collection,
        'deadline': task.deadline,
        'is_done': task.isDone,
      });
    } catch (e) {
      debugPrint('Error updating task: $e');
    }
  }
}
