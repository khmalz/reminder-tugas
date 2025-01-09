import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';

import '../../routes/app_pages.dart';

class ListTugas extends StatelessWidget {
  const ListTugas({
    super.key,
    required this.id,
    required this.namaTugas,
    required this.matkul,
    required this.tipe,
    required this.pengumpulan,
    required this.deadline,
  });

  final String id;
  final String namaTugas;
  final String matkul;
  final String tipe;
  final String pengumpulan;
  final String deadline;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.toNamed(Routes.DETAIL_TUGAS, parameters: {'id': id}),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tileColor: textPrimary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            namaTugas,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "$tipe | $pengumpulan",
            style: TextStyle(
              fontSize: 20,
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          Text(
            deadline,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
