import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medico/model/payment_controller.dart';


//import '../model/main_chat.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: (){
                //Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ChatBot()));
              },
              child: const Text("Chat Bot"),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){
                paymentController.makePayment(amount: "5", currency: "USD");
              },
              child: const Text("Make Payment"),
            ),
          ],
        ),
      ),
    );
  }
}
