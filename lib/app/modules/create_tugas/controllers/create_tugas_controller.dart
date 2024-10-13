import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTugasController extends GetxController {
  TextEditingController matkulController = TextEditingController();
  TextEditingController tugasController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController tipeController = TextEditingController();
  TextEditingController pengumpulanController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  Rxn<Map<String, dynamic>> matkul = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> tugas = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> deadline = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> tipe = Rxn<Map<String, dynamic>>(null);
  Rxn<Map<String, dynamic>> pengumpulan = Rxn<Map<String, dynamic>>(null);
  var dates = <DateTime?>[].obs;
}
