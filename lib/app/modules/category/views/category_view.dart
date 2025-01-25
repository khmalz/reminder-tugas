import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: textPrimary,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 27,
            ),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                },
              );
            },
          ),
        ],
      ),
      body: ContainedTabBarView(
        tabBarProperties: TabBarProperties(
          indicatorColor: Theme.of(context).colorScheme.primary,
          indicatorWeight: 5,
          margin: const EdgeInsets.all(10),
        ),
        tabs: [
          Text(
            'Nama',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Tipe',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Pengumpulan',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
        views: [
          Obx(() {
            return ListView.builder(
              itemCount: controller.specName.length,
              itemBuilder: (context, index) {
                final item = controller.specName[index];
                return ListTile(
                  onTap: () {},
                  title: Text(
                    item['title'] ?? 'No Title',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await showOkCancelAlertDialog(
                            context: context,
                            title: 'Hapus Kategori',
                            message:
                                'Menghapus kategori ini maka menghapus juga data yang berkaitan dengan ini, apakah anda yakin ingin menghapus kategori ini?',
                            okLabel: "Hapus",
                          );

                          if (result == OkCancelResult.ok) {
                            controller.deleteSpec('name', item['code']);
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 28,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
          Obx(() {
            return ListView.builder(
              itemCount: controller.specType.length,
              itemBuilder: (context, index) {
                final item = controller.specType[index];
                return ListTile(
                  onTap: () {},
                  title: Text(
                    item['title'] ?? 'No Title',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await showOkCancelAlertDialog(
                            context: context,
                            title: 'Hapus Kategori',
                            message:
                                'Menghapus kategori ini maka menghapus juga data yang berkaitan dengan ini, apakah anda yakin ingin menghapus kategori ini?',
                            okLabel: "Hapus",
                          );

                          if (result == OkCancelResult.ok) {
                            controller.deleteSpec('type', item['code']);
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 28,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
          Obx(() {
            return ListView.builder(
              itemCount: controller.specCollection.length,
              itemBuilder: (context, index) {
                final item = controller.specCollection[index];
                return ListTile(
                  onTap: () {
                    debugPrint(item['code']);
                  },
                  title: Text(
                    item['title'] ?? 'No Title',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await showOkCancelAlertDialog(
                            context: context,
                            title: 'Hapus Kategori',
                            message:
                                'Menghapus kategori ini maka menghapus juga data yang berkaitan dengan ini, apakah anda yakin ingin menghapus kategori ini?',
                            okLabel: "Hapus",
                          );

                          if (result == OkCancelResult.ok) {
                            controller.deleteSpec('collection', item['code']);
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 28,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
