import 'package:flutter/material.dart';

class CustomPhoneField extends StatelessWidget {
  const CustomPhoneField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.validator});
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2.5),
        ),
      ),
    );
  }
}
