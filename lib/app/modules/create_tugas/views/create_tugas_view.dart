import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';
import 'package:reminder_tugas/app/modules/create_tugas/widgets/create_task_form.dart';

class CreateTugasView extends GetView {
  const CreateTugasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Buat Tugas'),
        backgroundColor: primary,
        centerTitle: true,
        foregroundColor: textPrimary,
      ),
      body: ListView(
        children: [
          CreateTaskForm(),
        ],
      ),
    );
  }
}
