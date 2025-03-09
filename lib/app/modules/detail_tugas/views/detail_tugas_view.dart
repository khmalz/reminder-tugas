import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';
import 'package:reminder_tugas/app/data/widgets/button.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

import '../controllers/detail_tugas_controller.dart';
import '../widgets/content.dart';
import '../widgets/header.dart';

class DetailTugasView extends GetView<DetailTugasController> {
  const DetailTugasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tugas'),
        backgroundColor: primary,
        centerTitle: true,
        foregroundColor: textPrimary,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              size: 27,
            ),
            onPressed: () async {
              if (await confirm(context)) {
                controller.deleteTask(controller.id);
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.loadTugasById(controller.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            var tugas = snapshot.data!;

            return ListView(
              children: [
                Header(
                  name: tugas.name!,
                  matkul: tugas.matkul!,
                ),
                Content(
                  tugas: tugas,
                ),
                SizedBox(height: 20),
                Column(
                  spacing: 10,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Button(
                        text: 'Edit Tugas',
                        bgColor: Colors.deepOrange,
                        onClick: () => Get.toNamed(
                          Routes.UPDATE_TUGAS,
                          arguments: tugas.toJson(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Button(
                        text: tugas.isDone ? 'Batalkan' : 'Selesaikan Tugas',
                        bgColor: tugas.isDone ? Colors.red : primary,
                        onClick: () =>
                            controller.updateStatusTask(tugas.isDone),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
