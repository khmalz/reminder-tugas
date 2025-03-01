import 'package:flutter/material.dart';
import 'add_modal.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.add,
        size: 27,
      ),
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return const AddModal();
          },
        );
      },
    );
  }
}
