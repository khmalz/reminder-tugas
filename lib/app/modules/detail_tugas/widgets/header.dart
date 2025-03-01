import 'package:flutter/material.dart';
import 'package:reminder_tugas/app/data/constant/color.dart' show textPrimary;

class Header extends StatelessWidget {
  final String matkul;
  final String name;

  const Header({
    super.key,
    required this.matkul,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: textPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(100),
            spreadRadius: 2,
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$matkul - $name',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
