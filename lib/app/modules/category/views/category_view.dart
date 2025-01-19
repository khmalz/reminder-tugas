import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
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
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Tipe',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Pengumpulan',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
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
                      fontSize: 22,
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
                          size: 32,
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
                      fontSize: 22,
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
                          size: 32,
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
                      fontSize: 22,
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
                          size: 32,
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
