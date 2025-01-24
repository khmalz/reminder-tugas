import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/constant/color.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(TaskAdapter());
  
  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      title: "Reminder Task",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
        ).apply(
          bodyColor: textSecondary,
          displayColor: textPrimary,
        ),
        useMaterial3: true,
      ),
    ),
  );
}
