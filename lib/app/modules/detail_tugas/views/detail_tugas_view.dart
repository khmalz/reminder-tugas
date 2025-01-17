import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

import '../controllers/detail_tugas_controller.dart';

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
          } else if (snapshot.hasData) {
            var tugas = snapshot.data!;

            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: textPrimary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${tugas.matkul} - ${tugas.name}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: textPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tipe Tugas",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                tugas.type!,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Pengumpulan Tugas",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                tugas.collection!,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Deadline Tugas",
                                style: TextStyle(fontSize: 20),
                              ),
                              // Membungkus Text dalam Flexible
                              Flexible(
                                child: Text(
                                  tugas.deadline!,
                                  style: TextStyle(fontSize: 20),
                                  maxLines: 2, // Mengatur jumlah maksimum baris
                                  overflow: TextOverflow
                                      .ellipsis, // Menambahkan titik-titik jika lebih dari 2 baris
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.UPDATE_TUGAS,
                        arguments: tugas.toJson()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Edit Tugas',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () => controller.updateStatusTask(tugas.isDone),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tugas.isDone ? Colors.red : primary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      tugas.isDone ? 'Batalkan' : 'Selesaikan Tugas',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }
}
