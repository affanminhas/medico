import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            //Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ChatBot()));
          },
          child: const Text("Chat Bot"),
        ),
      ),
    );
  }
}
