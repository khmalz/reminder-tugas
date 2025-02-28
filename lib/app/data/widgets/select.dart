import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Select extends StatelessWidget {
  final String label;
  final Rxn<Map<String, dynamic>> selectedItem;
  final List<Map<String, dynamic>> items;
  final Rxn<String>? errorText;
  final Function(Map<String, dynamic>?)? onChanged;

  const Select({
    super.key,
    required this.label,
    required this.selectedItem,
    required this.items,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: Obx(
            () => DropdownSearch<Map<String, dynamic>>(
              popupProps: const PopupProps.menu(
                showSearchBox: false,
                fit: FlexFit.loose,
              ),
              itemAsString: (item) => item['title'],
              items: items,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: label,
                  errorText: errorText?.value,
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
              onChanged: (value) {
                selectedItem.value = value;
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
              selectedItem: selectedItem.value,
            ),
          ),
        ),
      ],
    );
  }
}
