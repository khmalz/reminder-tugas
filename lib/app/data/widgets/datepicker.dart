import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class Datepicker extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final RxList<DateTime?> selectedDates;
  final Rxn<String>? errorText;
  final VoidCallback? onValidate;

  const Datepicker({
    super.key,
    required this.label,
    required this.controller,
    required this.selectedDates,
    this.errorText,
    this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: Obx(
            () => TextField(
              controller: controller,
              readOnly: true,
              onTap: () async {
                await showDialog<List<DateTime?>>(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      insetPadding: const EdgeInsets.all(10),
                      child: Container(
                        width: double.infinity,
                        height: 450,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Text(
                              'Pilih Tanggal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: CalendarDatePicker2(
                                config: CalendarDatePicker2Config(
                                  calendarType: CalendarDatePicker2Type.single,
                                ),
                                value: selectedDates,
                                onValueChanged: (dates) {
                                  selectedDates.value = dates;
                                  if (dates.isNotEmpty) {
                                    controller.text = DateFormat('d MMMM yyyy')
                                        .format(dates[0]);
                                  }

                                  if (onValidate != null) {
                                    onValidate!();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(selectedDates);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.black45),
                hintText: selectedDates.isEmpty || selectedDates[0] == null
                    ? 'Pilih Tanggal'
                    : controller.text,
                errorText: errorText?.value,
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.4),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
