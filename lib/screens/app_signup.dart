import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medico/widgets/text_emailfield.dart';
import 'package:medico/widgets/text_passwordfield.dart';
import '../widgets/text_namefield.dart';
import '../widgets/text_phonefield.dart';
import 'app_home.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  UserCredential? authResult;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'Français', 'locale': const Locale('fr', 'FR')},
  ];

  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  buildDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: const Text("Choose a language"),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: (){
                            updateLanguage(locale[index]['locale']);
                          },
                          child: Text(locale[index]['name'],)),
                    );
                  },
                  separatorBuilder: (context, index){
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length
              ),
            ),
          );
        });
  }

  void submit()async{
    setState(() {
      isLoading = true;
    });
    try{
      authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> HomePage()));
    }on PlatformException catch (e){
      String message = "Please check your internet connection";
      if (e.message != null){
        message = e.message.toString();
      }
      //scaffold.currentState?.showSnackBar(SnackBar(content: Text(message)));
      setState(() {
        isLoading = false;
      });

    }catch(e){
      setState(() {
        isLoading = false;
      });
      //scaffold.currentState?.showSnackBar(SnackBar(content: Text(e.toString())));
    }
    await FirebaseFirestore.instance.collection("UserData").doc(authResult?.user?.uid).set({
      "UserId": authResult?.user?.uid,
      "UserName": nameController.text,
      "UserEmail": emailController.text,
      "UserPhone": phoneController.text,
      "UserPassword": passwordController.text
    });
    setState(() {
      isLoading = false;
    });
  }

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffold,
      body: Form(
        child: Builder(
            builder: (childContext) {
              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                      Colors.blueAccent,
                      Colors.lightBlue,
                      Colors.lightBlueAccent
                    ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "signup".tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "create account".tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(60))),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 45, left: 25, right: 25),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                        elevation: MaterialStateProperty.all(0),
                                      ),
                                      onPressed: () {
                                        buildDialog(context);
                                      },
                                      child: Text(
                                        "change language".tr,
                                        style: const TextStyle(
                                            fontFamily: "Poppins", color: Colors.black),
                                      )),
                                  const SizedBox(
                                    height: 50,
                                  ),

                                  // --- Name Field -- //
                                  Container(
                                    decoration: const BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(
                                              38, 149, 234, 0.30196078431372547),
                                          blurRadius: 10,
                                          offset: Offset(5, 10))
                                    ]),
                                    child: NameField(
                                        controller: nameController, title: "name".tr),
                                  ),

                                  // --- Email Field --- //
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      decoration: const BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                38, 149, 234, 0.30196078431372547),
                                            blurRadius: 10,
                                            offset: Offset(5, 10))
                                      ]),
                                      child: EmailField(
                                          controller: emailController, title: "email".tr),
                                    ),
                                  ),

                                  // --- Contact Field ---//
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      decoration: const BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                38, 149, 234, 0.30196078431372547),
                                            blurRadius: 10,
                                            offset: Offset(5, 10))
                                      ]),
                                      child: PhoneField(
                                          controller: phoneController, title: "phone".tr),
                                    ),
                                  ),

                                  // --- Password Field ---//
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      decoration: const BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                38, 149, 234, 0.30196078431372547),
                                            blurRadius: 10,
                                            offset: Offset(5, 10))
                                      ]),
                                      child: PasswordField(
                                          controller: passwordController, title: "password".tr),
                                    ),
                                  ),

                                  // --- signUp Button ---//
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Container(
                                        height: 50,
                                        width: widthVariable,
                                        child: !isLoading? ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                            shadowColor: MaterialStateProperty.all<Color>(Colors.white),
                                          ),
                                          onPressed: (){
                                            if(Form.of(childContext)?.validate() ?? false){
                                              submit();
                                            }
                                          },
                                          child: Text(
                                            "signup".tr,style: const TextStyle(
                                              fontSize: 22,
                                              fontFamily: "Poppins",
                                              color: Colors.white
                                          ),
                                          ),
                                        ): const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                    ),
                                  ),

                                  // --- Having account or not text ---//
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("already account".tr, style: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF868889),
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w300
                                        ),),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text(" login".tr, style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold
                                          ),),
                                        )
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
