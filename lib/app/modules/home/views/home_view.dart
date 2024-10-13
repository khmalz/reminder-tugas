import 'package:flutter/material.dart';

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
      ),
      body: ListView(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: textPrimary,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
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
                      'Yang belum',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textSecondary,
                      ),
                    ),
                    Text(
                      '10',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Yang sudah',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textSecondary,
                      ),
                    ),
                    Text(
                      '10',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              ListTugas(
                namaTugas: "Makalah",
                matkul: "Pancasila",
                tipe: "Kelompok",
                pengumpulan: "LMS",
                deadline: "20 Sep 2024",
              ),
              ListTugas(
                namaTugas: "Makalah",
                matkul: "Pancasila",
                tipe: "Individu",
                pengumpulan: "LMS",
                deadline: "20 Sep 2024",
              ),
              ListTugas(
                namaTugas: "Makalah",
                matkul: "Pancasila",
                tipe: "Individu",
                pengumpulan: "LMS",
                deadline: "20 Sep 2024",
              ),
              ListTugas(
                namaTugas: "Makalah",
                matkul: "Pancasila",
                tipe: "Individu",
                pengumpulan: "LMS",
                deadline: "20 Sep 2024",
              ),
            ],
          )
        ],
      ),
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
