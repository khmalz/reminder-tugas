import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:reminder_tugas/app/data/constant/talker.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'package:reminder_tugas/app/data/provider/logging_provider.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DetailTugasController extends GetxController {
  String id = Get.parameters['id'].toString();
  final Talker talker = LoggingProvider.talker;

  Future<void> deleteTask(String id) async {
    try {
      final box = await Hive.openBox<Task>('main');
      final key = box.keys.firstWhere((key) => box.get(key)!.id == id);
      await box.delete(key);

      talker.logCustom(LogGood('Task deleted successfully!'));

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.rawSnackbar(
        message: "Failed to delete task: ${e.toString()}",
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );

      talker.error("Error deleting task: $e");
    }
  }

  Future<void> updateStatusTask(bool status) async {
    try {
      final box = await Hive.openBox<Task>('main');
      final key = box.keys.firstWhere((key) => box.get(key)!.id == id);
      Task task = box.get(key)!;
      task.isDone = !status;

      await box.put(key, task);

      talker.logCustom(status
          ? LogGood('Task completed successfully!')
          : LogGood('Task cancelled successfully!'));

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      talker.error("Error updating task: $e");
    }
  }

  Future<Task?> loadTugasById(String id) async {
    try {
      final box = await Hive.openBox<Task>('main');
      Task taskData = box.values.firstWhere((task) => task.id == id);

      talker.info("Task detail loaded successfully!");

      return taskData;
    } catch (e) {
      Get.rawSnackbar(
        message: "Failed to load task: ${e.toString()}",
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );
      talker.error("Error loading task: $e");
      return null;
    }
  }
}
