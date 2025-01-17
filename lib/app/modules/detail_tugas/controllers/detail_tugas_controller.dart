import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

class DetailTugasController extends GetxController {
  var db = FirebaseFirestore.instance;
  String id = Get.parameters['id'].toString();

  Future<void> deleteTask(String id) async {
    try {
      await db.collection("tasks").doc(id).delete();

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      debugPrint('Error deleting task: $e');
    }
  }

  Future<void> updateStatusTask(bool status) async {
    try {
      await db.collection("tasks").doc(id).update({'is_done': !status});

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      debugPrint('Error deleting task: $e');
    }
  }

  Future<Task?> loadTugasById(String id) async {
    try {
      var doc = await db.collection("tasks").doc(id).get();

      // Memeriksa apakah dokumen ada
      if (doc.exists) {
        Task task = Task(
          id: doc.id,
          name: doc['name'],
          matkul: doc['matkul'],
          type: doc['type'],
          collection: doc['collection'],
          deadline: DateFormat('dd MMMM yyyy')
              .format((doc['deadline'] as Timestamp).toDate()),
          isDone: doc['is_done'],
        );

        // debugPrint(task.toString());

        return task;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getting task: $e');
      return null;
    }
  }
}
