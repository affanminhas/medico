import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  NameField({required this.controller, required this.title});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: (currentValue) {
          var nonNullable = currentValue ?? "";
          if (nonNullable.isEmpty) {
            return "Name field can't be empty!";
          }else if(nonNullable.length<5){
            return "Please enter your full name";
          }
          return null;
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: title,
            prefixIcon: const Icon(Icons.person),
            hintStyle: const TextStyle(fontFamily: "Poppins"),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10))));
  }
}
