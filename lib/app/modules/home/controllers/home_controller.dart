// import 'package:flutter/material.dart' show debugPrint;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';

class HomeController extends GetxController {
  Rx<List<Map<String, int>>> statList = Rx<List<Map<String, int>>>([
    {"late": 0},
    {"pending": 0},
    {"done": 0},
  ]);

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  Future<List<Task>> getTasks() async {
    final box = await Hive.openBox<Task>('main');
    await box.clear();

    await box.add(Task(
      id: "1",
      name: "Tugas 1",
      matkul: "Matematika",
      type: "UTS",
      collection: "Mandiri",
      deadline: "20 February 2025",
      isDone: false,
    ));

    List<Task> tasks = box.values.toList();

    int late = 0, pending = 0, done = 0;

    for (var task in tasks) {
      DateTime taskDeadline = DateFormat('dd MMMM yyyy').parse(task.deadline!);

      if (taskDeadline.isBefore(DateTime.now())) {
        late++;
      }

      if (task.isDone == false) {
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

    return tasks;
  }
}
