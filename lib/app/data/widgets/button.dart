import 'package:flutter/material.dart';
import 'package:reminder_tugas/app/data/constant/color.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color? bgColor;

  const Button({
    super.key,
    required this.text,
    required this.onClick,
    this.bgColor = primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onClick(),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: textPrimary,
        minimumSize: const Size(double.infinity, 0),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: textPrimary,
        ),
      ),
    );
  }
}
