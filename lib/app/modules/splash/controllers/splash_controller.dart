import 'package:get/get.dart';
import 'package:reminder_tugas/app/helper/spec.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await getSpecTask();

    if (!isLoading) Get.offAllNamed(Routes.HOME);
  }
}
