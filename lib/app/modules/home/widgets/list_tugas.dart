import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';
import 'package:reminder_tugas/app/modules/home/controllers/home_controller.dart';

import '../../../routes/app_pages.dart';

class ListTugas extends GetWidget<HomeController> {
  const ListTugas({
    super.key,
    required this.id,
    required this.namaTugas,
    required this.matkul,
    required this.tipe,
    required this.pengumpulan,
    required this.deadline,
    this.isDone = false,
  });

  final String id;
  final String namaTugas;
  final String matkul;
  final String tipe;
  final String pengumpulan;
  final String deadline;
  final bool? isDone;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.toNamed(Routes.DETAIL_TUGAS, parameters: {'id': id}),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tileColor: isDone != true ? textPrimary : fourth,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            namaTugas,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              decoration: isDone == true ? TextDecoration.lineThrough : null,
            ),
          ),
          Text(
            "$tipe | $pengumpulan",
            style: TextStyle(
              fontSize: 16,
              decoration: isDone == true ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            matkul,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
              decoration: isDone == true ? TextDecoration.lineThrough : null,
            ),
          ),
          Text(
            deadline,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              decoration: isDone == true ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}
