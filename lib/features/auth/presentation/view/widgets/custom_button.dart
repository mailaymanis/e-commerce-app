import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key , required this.onPressed , required this.text});
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.orangeAccent,
      ),
      child: Text(text , style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),),
    );
  }
}
