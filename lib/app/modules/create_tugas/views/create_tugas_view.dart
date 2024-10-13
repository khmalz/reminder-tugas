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
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => DropdownSearch<Map<String, dynamic>>(
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                          ),
                          itemAsString: (item) => item['label'],
                          // clearButtonProps: const ClearButtonProps(isVisible: true),
                          items: const [
                            {
                              "label": "JNE",
                              "code": "jne",
                            },
                            {
                              "label": "POS Indonesia",
                              "code": "pos",
                            },
                            {
                              "label": "TIKI",
                              "code": "tiki",
                            },
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primary,
                                ),
                              ),
                              labelText: "Mata Kuliah",
                              errorText: null,
                            ),
                          ),
                          onChanged: (value) {},
                          selectedItem: controller.matkul.value,
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
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => DropdownSearch<Map<String, dynamic>>(
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                          ),
                          itemAsString: (item) => item['label'],
                          // clearButtonProps: const ClearButtonProps(isVisible: true),
                          items: const [
                            {
                              "label": "JNE",
                              "code": "jne",
                            },
                            {
                              "label": "POS Indonesia",
                              "code": "pos",
                            },
                            {
                              "label": "TIKI",
                              "code": "tiki",
                            },
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primary,
                                ),
                              ),
                              labelText: "Jenis Tugas",
                              errorText: null,
                            ),
                          ),
                          onChanged: (value) {},
                          selectedItem: controller.matkul.value,
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
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => DropdownSearch<Map<String, dynamic>>(
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                          ),
                          itemAsString: (item) => item['label'],
                          // clearButtonProps: const ClearButtonProps(isVisible: true),
                          items: const [
                            {
                              "label": "JNE",
                              "code": "jne",
                            },
                            {
                              "label": "POS Indonesia",
                              "code": "pos",
                            },
                            {
                              "label": "TIKI",
                              "code": "tiki",
                            },
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primary,
                                ),
                              ),
                              labelText: "Tipe Tugas",
                              errorText: null,
                            ),
                          ),
                          onChanged: (value) {},
                          selectedItem: controller.matkul.value,
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
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => DropdownSearch<Map<String, dynamic>>(
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                          ),
                          itemAsString: (item) => item['label'],
                          // clearButtonProps: const ClearButtonProps(isVisible: true),
                          items: const [
                            {
                              "label": "JNE",
                              "code": "jne",
                            },
                            {
                              "label": "POS Indonesia",
                              "code": "pos",
                            },
                            {
                              "label": "TIKI",
                              "code": "tiki",
                            },
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primary,
                                ),
                              ),
                              labelText: "Pengumpulan",
                              errorText: null,
                            ),
                          ),
                          onChanged: (value) {},
                          selectedItem: controller.matkul.value,
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
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Obx(
                          () => TextField(
                            onTap: () async {
                              // Menampilkan alert dialog saat area disentuh dan menunggu hasilnya
                              await showDialog<List<DateTime?>>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Deadline'),
                                    content: SizedBox(
                                      width: 300,
                                      height: 350,
                                      child: CalendarDatePicker2(
                                        config: CalendarDatePicker2Config(
                                          calendarType:
                                              CalendarDatePicker2Type.single,
                                        ),
                                        value: controller.dates, // Nilai awal
                                        onValueChanged: (dates) {
                                          controller.dates.value = dates;
                                        },
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(controller
                                              .dates); // Kembalikan tanggal yang dipilih
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              // debugPrint(controller.dates.toString());
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: controller.dates.isEmpty ||
                                      controller.dates[0] == null
                                  ? 'Pilih tanggal'
                                  : DateFormat('d MMM yyyy')
                                      .format(controller.dates[0]!),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
