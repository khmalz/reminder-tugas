import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'package:reminder_tugas/app/data/provider/task_provider.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

class DetailTugasController extends GetxController {
  final TaskProvider _taskProvider = TaskProvider();
  String id = Get.parameters['id'].toString();

  Future<void> deleteTask(String id) async {
    try {
      await _taskProvider.deleteTask(id);

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.rawSnackbar(
        message: "Failed to delete task: ${e.toString()}",
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );

      debugPrint('Error deleting task: $e');
    }
  }

  Future<void> updateStatusTask(bool status) async {
    try {
      await _taskProvider.updateStatusTask(id, status);

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      debugPrint('Error deleting task: $e');
    }
  }

  Future<Task?> loadTugasById(String id) async {
    try {
      var taskData = await _taskProvider.loadTaskById(id);

      if (taskData != null) {
        Task task = Task(
          id: taskData['id'],
          name: taskData['name'],
          matkul: taskData['matkul'],
          type: taskData['type'],
          collection: taskData['collection'],
          deadline: DateFormat('dd MMMM yyyy')
              .format((taskData['deadline'] as Timestamp).toDate()),
          isDone: taskData['is_done'],
        );

        return task;
      } else {
        return null;
      }
    } catch (e) {
      Get.rawSnackbar(
        message: "Failed to load task: ${e.toString()}",
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );
      debugPrint('Error loading task: $e');
      return null;
    }
  }
}
