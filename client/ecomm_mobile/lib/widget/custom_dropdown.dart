import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      this.initialValue,
      this.bgColor,
      required this.items,
      required this.onChanged,
      this.validator,
      this.hintText = 'Select an option',
      required this.displayItem});
  final T? initialValue;
  final Color? bgColor;
  final List<T> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String hintText;
  final String Function(T) displayItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Text(
              hintText,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: items.map(
              (T value) {
                return DropdownMenuItem(
                  value: value,
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      displayItem(value),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ).toList(),
            value: initialValue,
            onChanged: onChanged,
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.only(left: 16, right: 8),
              height: 50,
              decoration: BoxDecoration(
                color: bgColor ?? Colors.grey.shade200,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            menuItemStyleData:
                const MenuItemStyleData(height: 40, padding: EdgeInsets.zero),
          ),
        ),
      ),
    );
  }
}
