import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';

class FloatingAddButton extends GetWidget {
  const FloatingAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CREATE_TUGAS),
        backgroundColor: primary,
        child: Icon(Icons.add, color: textPrimary),
      ),
    );
  }
}
