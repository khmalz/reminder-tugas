import 'package:get/get.dart';

import '../modules/create_tugas/bindings/create_tugas_binding.dart';
import '../modules/create_tugas/views/create_tugas_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TUGAS,
      page: () => const CreateTugasView(),
      binding: CreateTugasBinding(),
    ),
  ];
}
