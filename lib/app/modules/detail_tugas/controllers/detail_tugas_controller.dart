import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';

class DetailTugasController extends GetxController {
  String id = Get.parameters['id'].toString();

  Future<Task?> loadTugasById(String id) async {
    String jsonString = await rootBundle.loadString('assets/data/tugas.json');

    Map<String, dynamic> jsonResponse = json.decode(jsonString);
    List<dynamic> tugasData = jsonResponse['tugas'];

    // Mencari tugas dengan ID yang sesuai
    var tugasItem = tugasData.firstWhere(
      (t) => t['id'].toString() == id,
      orElse: () => null,
    );

    if (tugasItem != null) {
      return Task.fromJson(tugasItem);
    } else {
      return null;
    }
  }
}
