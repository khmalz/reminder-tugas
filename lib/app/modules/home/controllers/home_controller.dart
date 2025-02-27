// import 'package:flutter/material.dart' show debugPrint;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'package:reminder_tugas/app/data/provider/logging_provider.dart';
import 'package:talker_flutter/talker_flutter.dart' show Talker;

class HomeController extends GetxController {
  final Talker talker = LoggingProvider.talker;
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
    // await box.clear();

    // await box.add(Task(
    //   id: "2",
    //   name: "Tugas 2",
    //   matkul: "Matematika",
    //   type: "Soal",
    //   collection: "Mandiri",
    //   deadline: "10 February 2025",
    //   isDone: false,
    // ));

    // var specBox = await Hive.openBox('specs');
    // await specBox.clear();

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

    talker.info('Task loaded successfully!');
    talker.debug({'tasksLen': tasks.length, 'statList': statList.value});

    return tasks;
  }
}
