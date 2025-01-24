import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

class DetailTugasController extends GetxController {
  String id = Get.parameters['id'].toString();

  Future<void> deleteTask(String id) async {
    try {
      final box = await Hive.openBox<Task>('main');
      final key = box.keys.firstWhere((key) => box.get(key)!.id == id);
      await box.delete(key);

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
      final box = await Hive.openBox<Task>('main');
      final key = box.keys.firstWhere((key) => box.get(key)!.id == id);
      Task task = box.get(key)!;
      task.isDone = !status;

      await box.put(key, task);

      debugPrint("Task updated successfully!");
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      debugPrint('Error updating task: $e');
    }
  }

  Future<Task?> loadTugasById(String id) async {
    try {
      final box = await Hive.openBox<Task>('main');
      Task taskData = box.values.firstWhere((task) => task.id == id);

      return taskData;
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
