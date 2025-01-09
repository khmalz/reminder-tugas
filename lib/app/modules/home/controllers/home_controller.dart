import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class HomeController extends GetxController {
  var tugasList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTugas();
  }

  Future<void> loadTugas() async {
    String jsonString = await rootBundle.loadString('assets/data/tugas.json');

    Map<String, dynamic> jsonResponse = json.decode(jsonString);
    List<dynamic> tugasData = jsonResponse['tugas'];

    tugasList.value = tugasData.cast<Map<String, dynamic>>();
  }
}
