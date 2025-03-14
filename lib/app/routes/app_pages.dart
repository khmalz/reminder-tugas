import 'package:get/get.dart';

import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/create_tugas/bindings/create_tugas_binding.dart';
import '../modules/create_tugas/views/create_tugas_view.dart';
import '../modules/detail_tugas/bindings/detail_tugas_binding.dart';
import '../modules/detail_tugas/views/detail_tugas_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/update_tugas/bindings/update_tugas_binding.dart';
import '../modules/update_tugas/views/update_tugas_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
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
    GetPage(
      name: _Paths.DETAIL_TUGAS,
      page: () => const DetailTugasView(),
      binding: DetailTugasBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_TUGAS,
      page: () => const UpdateTugasView(),
      binding: UpdateTugasBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
  ];
}
