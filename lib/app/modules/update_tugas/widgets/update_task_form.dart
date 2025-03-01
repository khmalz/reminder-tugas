import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/widgets/button.dart';
import 'package:reminder_tugas/app/data/widgets/datepicker.dart';
import 'package:reminder_tugas/app/data/widgets/select.dart';
import 'package:reminder_tugas/app/data/widgets/text_input.dart';
import '../controllers/update_tugas_controller.dart';

class UpdateTaskForm extends GetWidget<UpdateTugasController> {
  const UpdateTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          TextInput(
            label: "Matkul",
            controller: controller.matkul,
            hintText: "Input Matkul",
            errorText: controller.errorMatkul,
            onChanged: () => controller.validateMatkul(),
          ),
          const SizedBox(height: 20),
          Select(
            label: "Jenis Tugas",
            selectedItem: controller.jenisTugas,
            items: controller.specName,
            errorText: controller.errorJenis,
            onChanged: (value) => controller.validateJenis(),
          ),
          const SizedBox(height: 20),
          Select(
            label: "Tipe Tugas",
            selectedItem: controller.tipeTugas,
            items: controller.specType,
            errorText: controller.errorTipe,
            onChanged: (value) => controller.validateTipe(),
          ),
          const SizedBox(height: 20),
          Select(
            label: "Pengumpulan",
            selectedItem: controller.pengumpulan,
            items: controller.specCollection,
            errorText: controller.errorPengumpulan,
            onChanged: (value) => controller.validatePengumpulan(),
          ),
          const SizedBox(height: 20),
          Datepicker(
            label: "Deadline",
            controller: controller.deadline,
            selectedDates: controller.dates,
            errorText: controller.errorDeadline,
            onValidate: () => controller.validateDeadline(),
          ),
          const SizedBox(height: 20),
          Button(
            text: 'Save Changes',
            onClick: () => controller.updateTask(),
          ),
        ],
      ),
    );
  }
}
