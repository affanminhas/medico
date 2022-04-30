import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medico/widgets/text_emailfield.dart';
import 'package:medico/widgets/text_passwordfield.dart';
import '../model/signin_google.dart';
import 'app_home.dart';
import 'app_signup.dart';

// final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email'
//     ]
// );

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  UserCredential? authResult;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GoogleSignInAccount? _currentUser;

  // @override
  // void initState() {
  //   _googleSignIn.onCurrentUserChanged.listen((account) {
  //     setState(() {
  //       _currentUser = account;
  //     });
  //   });
  //   _googleSignIn.signInSilently();
  // }

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
                    return const Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length
              ),
            ),
          );
        });
  }

  void submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    } on PlatformException catch (e) {
      String message = "Please check your internet connection";
      if (e.message != null) {
        message = e.message.toString();
      }
      //scaffold.currentState?.showSnackBar(SnackBar(content: Text(message)));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //scaffold.currentState?.showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      isLoading = false;
    });
  }

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;
    GoogleSignInAccount? user = _currentUser;

    return Scaffold(
      key: scaffold,
      body: Form(
        child: Builder(builder: (childContext) {
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
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "login".tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: "Poppins"),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "welcome".tr,
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
                      padding:
                          const EdgeInsets.only(top: 45, left: 25, right: 25),
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
                          // --- Email Field --- //
                          Container(
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
                                  controller: passwordController,
                                  title: "password".tr),
                            ),
                          ),

                          // --- Forgot Password Text --- //
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "forgot".tr,
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: Color(0xFF868889)),
                              ),
                            ),
                          ),

                          // --- Login Button ---//
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Container(
                                height: 50,
                                width: widthVariable,
                                child: !isLoading
                                    ? ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.blue),
                                          shadowColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                        onPressed: () {
                                          if (Form.of(childContext)
                                                  ?.validate() ??
                                              false) {
                                            submit();
                                          }
                                        },
                                        child: Text(
                                          "login".tr,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontFamily: "Poppins",
                                              color: Colors.white),
                                        ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      )),
                          ),

                          // --- Have an account or not --- //
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "don't have account".tr,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF868889),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w300),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => SignUpScreen()));
                                  },
                                  child: Text(
                                    " signup".tr,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              googleLogin();
                              // googlesSignIn().whenComplete(() =>
                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=> HomePage()));
                              //);
                            },
                            child: Row(
                              children: [
                                Image(
                                  width: 200,
                                  height: 200,
                                  image: AssetImage("images/google_signin.png"),
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
        }),
      ),
    );
  }

  googleLogin() async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      }

      final userData = await reslut.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("Result $reslut");
      print(reslut.displayName);
      print(reslut.email);
      print(reslut.photoUrl);

    } catch (error) {
      print(error);
    }
  }

  // Future<void> signIn()async{
  //   try{
  //     await _googleSignIn.signIn();
  //     // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> HomePage()));
  //   }catch(e){
  //     print("SignIn has error $e");
  //   }
  // }
}
