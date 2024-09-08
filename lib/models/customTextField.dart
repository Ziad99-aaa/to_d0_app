import 'package:flutter/material.dart';
import 'package:to_d0_app/app_color.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController textController;
  bool scure;
  TextInputType keyboardType;
  String labelText;
  String? Function(String?) validator;
  CustomTextField({
    required this.labelText,
    required this.validator,
    required this.textController,
    required this.keyboardType,
    required this.scure,
  });

  Widget build(BuildContext context) {
    return TextFormField(
      
      style: TextStyle(color: AppColor.blackcolor),
      validator: validator,
      controller: textController,
      obscureText: scure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
