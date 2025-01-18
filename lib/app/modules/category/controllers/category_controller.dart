import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoryController extends GetxController {
  final box = GetStorage();
  RxList<Map<String, dynamic>> specName = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specType = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> specCollection = <Map<String, dynamic>>[].obs;

  void getSpecTask() async {
    Map<String, dynamic> specTask = await box.read('specTask')[0];

    specName.value = List<Map<String, dynamic>>.from(specTask['name']);
    specType.value = List<Map<String, dynamic>>.from(specTask['type']);
    specCollection.value =
        List<Map<String, dynamic>>.from(specTask['collection']);
  }

  @override
  void onInit() async {
    super.onInit();
    getSpecTask();
  }
}
