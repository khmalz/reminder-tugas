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
      body: FutureBuilder(
          future: controller.getTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Tidak ada tugas ditemukan.'));
            } else {
              var tugasList = snapshot.data!;

              return ListView(
                children: [
                  ColumnStats(
                    statList: controller.statList,
                  ),
                  Column(
                    children: tugasList
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
            }
          }),
      floatingActionButton: FloatingAddButton(),
    );
  }
}
