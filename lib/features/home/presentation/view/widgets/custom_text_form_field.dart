import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key , required this.onChanged});
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:onChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.clear),
        hintText: "Search...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:BorderSide(
            width:2,
            color:Colors.black
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:BorderSide(
              width:2,
              color:Colors.black
          ),
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:BorderSide(
              width:2,
              color:Colors.black
          ),
        ),
        errorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:BorderSide(
              width:2,
              color:Colors.black
          ),
        ),
      ),
    );
  }
}
