//Creation of a custom Provider object to be used for Google Login Data
//extension of a ChangeNotifier Provider Class

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


//This class object will use the Google Sign In module to allow the use of
//logging in and out using Google credentials
class GoogleSignInProvider extends ChangeNotifier{

  final googleSignIn = GoogleSignIn();
  bool? _isSigningIn;

  //constructor
  GoogleSignInProvider(){
    _isSigningIn = false;
  }

  //getter and setter functions
  bool? get isSigningIn => _isSigningIn;

  set isSigningIn(bool? isSigningIn){
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  //method used to login a user to Google Account
  Future login() async{
    isSigningIn = true;
    final user = await googleSignIn.signIn();

    if (user == null){
      isSigningIn = false;
      return;
    }

    else{
      //grab Google account authentication data
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      //pass Google account credentials to Firebase so data can be used
      //within this App
      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
    }

  }

  //method used to logout a user of Google account
  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
}

}
