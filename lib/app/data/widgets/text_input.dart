import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final Rxn<String>? errorText;
  final VoidCallback? onChanged;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;

  const TextInput({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: Obx(
            () => TextField(
              controller: controller,
              style: const TextStyle(color: Colors.black87),
              onChanged: (value) {
                if (onChanged != null) onChanged!();
              },
              textCapitalization: textCapitalization,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                hintStyle: const TextStyle(color: Colors.black45),
                hintText: hintText,
                filled: true,
                fillColor: Colors.white12,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.4,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.4,
                  ),
                ),
                errorText: errorText?.value, // Langsung ambil nilainya
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
              ),
              keyboardType: keyboardType,
              textInputAction: textInputAction,
            ),
          ),
        ),
      ],
    );
  }
}
