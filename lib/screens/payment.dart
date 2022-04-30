import 'package:flutter/material.dart';

class StripePayment extends StatelessWidget {

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: ()async{
              await makePayment();
            },
            child: Container(
              width: 200,
              height: 50,
              child: Center(
                  child: Text("Pay")
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> makePayment()async{
    try{
      paymentIntent = await createPaymentIntent("20", "USD");
    }catch(e){
      print("exeption"+e.toString());
    }
  }
  createPaymentIntent(String amount, String currency){
    try{
      Map<String, dynamic> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card"
      };
    }catch(e){
      print("exeption"+e.toString());
    }
  }
  calculateAmount(String amount){
    final price = int.parse(amount);
    return price;
  }
}
