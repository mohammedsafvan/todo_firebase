import 'package:flutter/material.dart';

Widget textField(String labelText, TextEditingController controller,BuildContext context,
    {bool obscureText = false}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 70,
    height: 55,
    child: TextFormField(
      keyboardType: labelText == 'Email' ? TextInputType.emailAddress : null,
      obscureText: obscureText,
      controller: controller,
      style: const TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2.5,
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
      ),
    ),
  );
}
