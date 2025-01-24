import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';

import 'package:get/get.dart';

import '../../../data/component/list_tugas.dart';
import '../../../data/constant/color.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

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
          CustomPopup(
            showArrow: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            barrierColor: Colors.transparent,
            contentDecoration: BoxDecoration(
              color: Colors.white,
            ),
            content: SizedBox(
              width: 0.4 * Get.width,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Get.toNamed(Routes.CATEGORY);
                      },
                      icon: const Icon(
                        Icons.content_paste,
                        size: 30,
                      ),
                      label: const Text('Kategori',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          )),
                    ),
                  ]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            ),
          ),
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
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: textPrimary,
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Telat',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textSecondary,
                              ),
                            ),
                            Text(
                              controller.statList.value[0]['late'].toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Belum',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textSecondary,
                              ),
                            ),
                            Text(
                              controller.statList.value[1]['pending']
                                  .toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade700,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Sudah',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textSecondary,
                              ),
                            ),
                            Text(
                              controller.statList.value[2]['done'].toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.CREATE_TUGAS),
          backgroundColor: primary,
          child: Icon(Icons.add, color: textPrimary),
        ),
      ),
    );
  }
}
