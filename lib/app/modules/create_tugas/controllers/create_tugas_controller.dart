import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class CreateTugasController extends GetxController {
  Rxn<Map<String, dynamic>> jenisTugas = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> tipeTugas = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> pengumpulan = Rxn<Map<String, dynamic>>(null);
  Rxn<String> deadline = Rxn<String>(null);
  var dates = <DateTime?>[].obs;

  var matkul = Rxn<Map<String, dynamic>>();
  var matkulList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMatkulData();
  }

  Future<void> loadMatkulData() async {
    String jsonString = await rootBundle.loadString('assets/data/matkul.json');

    Map<String, dynamic> jsonResponse = json.decode(jsonString);
    List<dynamic> matkulData = jsonResponse['mata_kuliah'];

    matkulList.value = matkulData.cast<Map<String, dynamic>>();
  }
}
