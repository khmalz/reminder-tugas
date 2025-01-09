import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';

class HomeController extends GetxController {
  Future<List<Task>> loadTugas() async {
    String jsonString = await rootBundle.loadString('assets/data/tugas.json');

    Map<String, dynamic> jsonResponse = json.decode(jsonString);
    List<dynamic> tugasData = jsonResponse['tugas'];

    List<Task> tasks = tugasData.map((task) => Task.fromJson(task)).toList();

    return tasks;
  }
}
