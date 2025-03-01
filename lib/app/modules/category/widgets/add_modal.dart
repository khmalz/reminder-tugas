import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/modules/category/controllers/category_controller.dart';

class AddModal extends GetWidget<CategoryController> {
  const AddModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Kategori'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return TextField(
              controller: controller.title,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5),
                hintText: 'Nama Kategori',
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                filled: true,
                fillColor: Colors.transparent,
                errorText: controller.errorTitle.value,
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onChanged: (_) {
                controller.validateTitle();
              },
            );
          }),
          SizedBox(height: 20),
          Obx(() {
            return DropdownSearch<Map<String, dynamic>>(
              popupProps: const PopupProps.menu(
                showSearchBox: false,
                fit: FlexFit.loose,
              ),
              itemAsString: (item) => item['title'],
              items: const [
                {
                  'title': 'Nama',
                  'code': 'name',
                },
                {
                  'title': 'Tipe',
                  'code': 'type',
                },
                {
                  'title': 'Pengumpulan',
                  'code': 'collection',
                },
              ],
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  labelText: "Jenis Kategori",
                  errorText: controller.errorJenis.value,
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
              onChanged: (value) {
                controller.jenis.value = value;
                controller.validateJenis();
              },
              selectedItem: controller.jenis.value,
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            controller.addSpecTask();
            Navigator.of(context).pop();
          },
          child: Text('Simpan'),
        ),
      ],
    );
  }
}
