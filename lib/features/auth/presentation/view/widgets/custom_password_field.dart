import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({super.key,required this.hint , required this.controller , required this.validator});
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool hiddenPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:widget.controller,
      validator:widget.validator,
      obscureText: hiddenPassword,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password),
        suffixIcon: IconButton(
          onPressed:(){
            setState(() {
              hiddenPassword = !hiddenPassword;
            });
          },
          icon: Icon(hiddenPassword ? Icons.visibility_off : Icons.visibility),),
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(
              width: 2.5
          ),
        ),
      ),
    );
  }
}
