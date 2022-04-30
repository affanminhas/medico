import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:medico/model/localStrings.dart';
import 'package:medico/screens/app_login.dart';
import 'package:get/get.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // --- Stripe publisher key --- //
  Stripe.publishableKey =
  'pk_live_51KtbPFAnFDHQiQ3thxRlXnYycwMafaBFxSDHp42aHyqOj64n2dJGXVfHsheXJhT98f5qthmxVOIaRY4tIBSf0vRt007yByHe4T';


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      transitionDuration: const Duration(milliseconds: 500),
      defaultTransition: Transition.fadeIn,
      translations: Localstring(),
      locale: const Locale('en','US'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}


