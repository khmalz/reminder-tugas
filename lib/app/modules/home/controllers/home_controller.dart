import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'package:reminder_tugas/app/data/provider/task_provider.dart';

class HomeController extends GetxController {
  final TaskProvider _taskProvider = TaskProvider();
  Rx<List<Map<String, int>>> statList = Rx<List<Map<String, int>>>([
    {"late": 0},
    {"pending": 0},
    {"done": 0},
  ]);

  Future<List<Task>> getTasks() async {
    List<Task> tasksList = [];
    int late = 0, pending = 0, done = 0;

    try {
      List<Map<String, dynamic>> tasksData = await _taskProvider.getTasks();

      for (var data in tasksData) {
        tasksList.add(Task(
          id: data['id'],
          name: data['name'],
          matkul: data['matkul'],
          type: data['type'],
          collection: data['collection'],
          deadline: DateFormat('dd MMMM yyyy')
              .format((data['deadline'] as Timestamp).toDate()),
          isDone: data['is_done'],
        ));

        DateTime taskDeadline = (data['deadline'] as Timestamp).toDate();

        if (taskDeadline.isBefore(DateTime.now())) {
          late++;
        }

        if (data['is_done'] == false) {
          pending++;
        } else {
          done++;
        }
      }

      statList.value = [
        {"late": late},
        {"pending": pending},
        {"done": done},
      ];

      return tasksList;
    } catch (e) {
      Get.rawSnackbar(
        message: "Failed to load tasks: ${e.toString()}",
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 8,
      );
      debugPrint('Error getting tasks: $e');
      return [];
    }
  }
}
