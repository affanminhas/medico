import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  PhoneField({required this.controller, required this.title});

  static String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.phone,
        controller: controller,
        validator: (currentValue) {
          var nonNullable = currentValue ?? "";
          if (nonNullable.isEmpty) {
            return "Contact field can't be empty!";
          }else if (!regExp.hasMatch(nonNullable)) {
            return 'Please enter valid mobile number';
          }
          return null;
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: title,
            prefixIcon: Icon(Icons.phone),
            hintStyle: const TextStyle(fontFamily: "Poppins"),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10))));
  }
}
