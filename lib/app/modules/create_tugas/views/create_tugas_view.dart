import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/constant/color.dart';
import '../controllers/create_tugas_controller.dart';

class CreateTugasView extends GetView<CreateTugasController> {
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
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const Text(
                        "Mata Kuliah",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => TextField(
                          controller: controller.matkul,
                          style: const TextStyle(color: textSecondary),
                          onChanged: (value) {
                            controller.validateMatkul();
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            hintStyle: TextStyle(
                              color: Colors.black45,
                            ),
                            hintText: "Input Matkul",
                            filled: true,
                            fillColor: Colors.white12,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.4,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.4,
                              ),
                            ),
                            errorText: controller.errorMatkul.value,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.red, width: 2),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const Text(
                        "Jenis Tugas",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => DropdownSearch<Map<String, dynamic>>(
                          itemAsString: (item) => item['title'],
                          // clearButtonProps: const ClearButtonProps(isVisible: true),
                          items: controller.specName,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primary,
                                ),
                              ),
                              labelText: "Jenis Tugas",
                              errorText: controller.errorJenis.value,
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            controller.jenisTugas.value = value;

                            controller.validateJenis();
                          },
                          selectedItem: controller.jenisTugas.value,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const Text(
                        "Tipe Tugas",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => DropdownSearch<Map<String, dynamic>>(
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                          ),
                          itemAsString: (item) => item['title'],
                          // clearButtonProps: const ClearButtonProps(isVisible: true),
                          items: controller.specType,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primary,
                                ),
                              ),
                              labelText: "Tipe Tugas",
                              errorText: controller.errorTipe.value,
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            controller.tipeTugas.value = value;

                            controller.validateTipe();
                          },
                          selectedItem: controller.tipeTugas.value,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const Text(
                        "Pengumpulan",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => DropdownSearch<Map<String, dynamic>>(
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                          ),
                          itemAsString: (item) => item['title'],
                          // clearButtonProps: const ClearButtonProps(isVisible: true),
                          items: controller.specCollection,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primary,
                                ),
                              ),
                              labelText: "Pengumpulan",
                              errorText: controller.errorPengumpulan.value,
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            controller.pengumpulan.value = value;

                            controller.validatePengumpulan();
                          },
                          selectedItem: controller.pengumpulan.value,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Deadline",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => TextField(
                          controller: controller.deadline,
                          onTap: () async {
                            await showDialog<List<DateTime?>>(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.all(10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 450,
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Pilih Tanggal',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Flexible(
                                          child: CalendarDatePicker2(
                                            config: CalendarDatePicker2Config(
                                              calendarType:
                                                  CalendarDatePicker2Type
                                                      .single,
                                            ),
                                            value: controller.dates,
                                            onValueChanged: (dates) {
                                              controller.dates.value = dates;
                                              controller.deadline.text =
                                                  DateFormat('d MMMM yyyy')
                                                      .format(
                                                          controller.dates[0]!);

                                              controller.validateDeadline();
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(controller.dates);
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            debugPrint(controller.dates.toString());
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.black45,
                            ),
                            hintText: controller.dates.isEmpty ||
                                    controller.dates[0] == null
                                ? 'Pilih Tanggal'
                                : controller.deadline.text,
                            errorText: controller.errorDeadline.value,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.4,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.createTask(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: textPrimary,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
