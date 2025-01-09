import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class DetailTugasController extends GetxController {
  String id = Get.parameters['id'].toString();

  Future<Map<String, dynamic>?> loadTugasById(String id) async {
    String jsonString = await rootBundle.loadString('assets/data/tugas.json');

    Map<String, dynamic> jsonResponse = json.decode(jsonString);
    List<dynamic> tugasData = jsonResponse['tugas'];

    // Mencari tugas dengan ID yang sesuai
    var tugasItem = tugasData.firstWhere(
      (t) => t['id'].toString() == id,
      orElse: () => null,
    );

    return tugasItem as Map<String, dynamic>?;
  }
}
