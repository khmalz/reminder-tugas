import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:reminder_tugas/app/data/constant/spec_task.dart' as spec;
import 'package:reminder_tugas/app/data/provider/logging_provider.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SplashController extends GetxController {
  final Talker talker = LoggingProvider.talker;

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
      talker.info('Kosong');

      await specBox.put('name', spec.specName);
      await specBox.put('type', spec.specType);
      await specBox.put('collection', spec.specCollection);
    } else {
      talker.info('Tidak Kosong');
    }
  }
}
