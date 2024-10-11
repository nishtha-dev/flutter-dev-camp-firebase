import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.buttonColor,
      this.buttonTextColor});
  final void Function() onPressed;
  final String buttonText;
  final Color? buttonTextColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor ?? Colors.white),
        ));
  }
}
