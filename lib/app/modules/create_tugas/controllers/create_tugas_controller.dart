import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTugasController extends GetxController {
  Rxn<Map<String, dynamic>> jenisTugas = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> tipeTugas = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> pengumpulan = Rxn<Map<String, dynamic>>(null);
  Rxn<String> deadline = Rxn<String>(null);
  var dates = <DateTime?>[].obs;

  final TextEditingController matkul = TextEditingController();
  Rxn<String> errorMatkul = Rxn<String>(null);
}
