import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.labelText,
      this.height,
      required this.controller,
      this.inputType = TextInputType.text,
      this.lineNumber = 1,
      required this.onSave,
      this.validator});
  final String labelText;
  final double? height;
  final TextEditingController controller;
  final TextInputType? inputType;
  final int? lineNumber;
  final void Function(String?) onSave;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          maxLines: lineNumber,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: AppColor.darkOrange,
              ),
            ),
          ),
          keyboardType: inputType,
          onSaved: (value) {
            onSave(value?.isEmpty ?? true ? null : value);
          },
          validator: validator,
          inputFormatters: [
            LengthLimitingTextInputFormatter(700),
            if (inputType == TextInputType.number)
              FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))
          ],
        ),
      ),
    );
  }
}
