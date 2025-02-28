import 'package:flutter/material.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onSave;

  const Button({
    super.key,
    required this.text,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onSave(),
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
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
