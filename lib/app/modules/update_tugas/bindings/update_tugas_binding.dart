import 'package:get/get.dart';

import '../controllers/update_tugas_controller.dart';

class UpdateTugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateTugasController>(
      () => UpdateTugasController(),
    );
  }
}
