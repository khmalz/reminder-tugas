import 'package:flutter/material.dart' show debugPrint;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:reminder_tugas/app/data/constant/spec_task.dart' as spec;
import 'package:reminder_tugas/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await initSpec();

    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onClose() {
    super.onClose();
    Hive.close();
  }

  Future<void> initSpec() async {
    // await Hive.deleteBoxFromDisk('specs');
    var specBox = await Hive.openBox('specs');

    if (specBox.isEmpty) {
      await specBox.clear();
      debugPrint('Kosong');

      await specBox.put('name', spec.specName);
      await specBox.put('type', spec.specType);
      await specBox.put('collection', spec.specCollection);
    } else {
      debugPrint('Tidak Kosong');
    }
  }
}
