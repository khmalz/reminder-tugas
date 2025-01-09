import 'package:get/get.dart';

import '../controllers/detail_tugas_controller.dart';

class DetailTugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTugasController>(
      () => DetailTugasController(),
    );
  }
}
