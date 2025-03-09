import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart' show textPrimary;
import 'package:reminder_tugas/app/data/models/task_model.dart' show Task;
import 'package:reminder_tugas/app/modules/detail_tugas/controllers/detail_tugas_controller.dart';

class Content extends GetWidget<DetailTugasController> {
  final Task tugas;

  const Content({
    super.key,
    required this.tugas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    tugas.type!,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Pengumpulan Tugas",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    tugas.collection!,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Deadline Tugas",
                    style: TextStyle(fontSize: 16),
                  ),
                  // Membungkus Text dalam Flexible
                  Flexible(
                    child: Text(
                      tugas.deadline!,
                      style: TextStyle(fontSize: 16),
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
    );
  }
}
