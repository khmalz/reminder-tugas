import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';

import '../controllers/category_controller.dart';
import '../widgets/add_button.dart';
import '../widgets/category_item.dart';

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
          AddButton(),
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
                return CategoryItem(
                  item: item,
                  onDelete: () => controller.deleteSpec(
                      'name', item['code'], item['title']),
                );
              },
            );
          }),
          Obx(() {
            return ListView.builder(
              itemCount: controller.specType.length,
              itemBuilder: (context, index) {
                final item = controller.specType[index];
                return CategoryItem(
                  item: item,
                  onDelete: () => controller.deleteSpec(
                      'type', item['code'], item['title']),
                );
              },
            );
          }),
          Obx(() {
            return ListView.builder(
              itemCount: controller.specCollection.length,
              itemBuilder: (context, index) {
                final item = controller.specCollection[index];
                return CategoryItem(
                  item: item,
                  onDelete: () => controller.deleteSpec(
                      'collection', item['code'], item['title']),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
