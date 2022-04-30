import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final googleSignInn = GoogleSignIn();
FirebaseAuth auth = FirebaseAuth.instance;

Future<bool> googlesSignIn()async{
  GoogleSignInAccount? googleSignInAccount = await googleSignInn.signIn();

  if(googleSignInAccount != null){
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
    );

    UserCredential result = await auth.signInWithCredential(credential);
    User? user = await auth.currentUser!;

    return Future.value(true);
  }
  return Future.value(false);
}

Future<bool> signOutUser()async{
  User? user = await auth.currentUser!;
  if(user.providerData[1].providerId == "google.com"){
    await googleSignInn.disconnect();
  }
  await auth.signOut();
  return Future.value(true);
}