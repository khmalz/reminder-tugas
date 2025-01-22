import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reminder_tugas/app/data/provider/spec_task_provider.dart';

final box = GetStorage();
final SpecTaskProvider _specTaskProvider = SpecTaskProvider();

bool isLoading = true;

Future<void> getSpecTask() async {
  try {
    isLoading = true;

    List<Map<String, dynamic>> groupedSpecs =
        await _specTaskProvider.getGroupedSpecs();

    await insertSpecTask(groupedSpecs);

    isLoading = false;
  } catch (e) {
    debugPrint('Error fetching specs: $e');
  }
}

Future<void> insertSpecTask(List<Map<String, dynamic>> specTaskData) async {
  if (box.hasData('specTask')) {
    box.remove('specTask');
  }

  await box.write('specTask', specTaskData);

  return;
}
