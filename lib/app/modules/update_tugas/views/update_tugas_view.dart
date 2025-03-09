import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';
import 'package:reminder_tugas/app/modules/update_tugas/widgets/update_task_form.dart';

class UpdateTugasView extends GetView {
  const UpdateTugasView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Update Tugas'),
        backgroundColor: primary,
        centerTitle: true,
        foregroundColor: textPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UpdateTaskForm(),
          ],
        ),
      ),
    );
  }
}
