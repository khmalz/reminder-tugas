import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:reminder_tugas/app/data/constant/color.dart' show textSecondary;

class CategoryItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onDelete;

  const CategoryItem({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item['title'] ?? 'No Title',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          final result = await showOkCancelAlertDialog(
            context: context,
            title: 'Hapus Kategori',
            message:
                'Menghapus kategori ini maka menghapus juga data yang berkaitan dengan ini, apakah anda yakin ingin menghapus kategori ini?',
            okLabel: "Hapus",
          );

          if (result == OkCancelResult.ok) {
            onDelete();
          }
        },
        icon: const Icon(
          Icons.delete,
          size: 28,
          color: textSecondary,
        ),
      ),
    );
  }
}
