import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';

import '../controllers/home_controller.dart';
import '../widgets/column_stats.dart';
import '../widgets/dropdown_home.dart';
import '../widgets/floating_add_button.dart';
import '../widgets/list_tugas.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder Tugas'),
        backgroundColor: primary,
        centerTitle: true,
        foregroundColor: textPrimary,
        actions: [
          DropdownHome(talker: controller.talker),
        ],
      ),
      body: Obx(() {
        if (controller.tasks.isEmpty) {
          return Center(child: Text("Tidak ada tugas ditemukan."));
        }

        return ListView(
          children: [
            ColumnStats(
              statList: controller.statList,
            ),
            Column(
              children: controller.tasks
                  .map((tugas) => ListTugas(
                        id: tugas.id!,
                        namaTugas: tugas.name!,
                        matkul: tugas.matkul!,
                        tipe: tugas.type!,
                        pengumpulan: tugas.collection!,
                        deadline: tugas.deadline!,
                        isDone: tugas.isDone,
                      ))
                  .toList(),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingAddButton(),
    );
  }
}
