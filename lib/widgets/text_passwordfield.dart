import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {

  final TextEditingController controller;
  final String title;
  PasswordField({required this.controller, required this.title});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        validator: (currentValue){
          var nonNullable = currentValue ?? "";
          if(nonNullable.isEmpty){
            return "Password field can't be empty!";
          }
          return null;
        },
        obscureText: obscureText,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: widget.title,
            prefixIcon: Icon(Icons.lock_outline),
            hintStyle: const TextStyle(
                fontFamily: "Poppins"
            ),
            suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(obscureText?Icons.visibility: Icons.visibility_off,)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)))
    );
  }
}
