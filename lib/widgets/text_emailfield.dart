import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {

  final TextEditingController controller;
  final String title;
  EmailField({required this.controller, required this.title});

  static String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        validator: (currentValue){
          var nonNullable = currentValue ?? "";
          if(nonNullable.isEmpty){
            return "Email field can't be empty!";
          }else if(!regExp.hasMatch(nonNullable)){
            return "Please enter valid email address";
          }return null;
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: title,
            prefixIcon: Icon(Icons.email_outlined),
            hintStyle: const TextStyle(
                fontFamily: "Poppins"
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)))
    );
  }
}
