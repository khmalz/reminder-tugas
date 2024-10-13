import 'package:get/get.dart';

import '../controllers/create_tugas_controller.dart';

class CreateTugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTugasController>(
      () => CreateTugasController(),
    );
  }
}
