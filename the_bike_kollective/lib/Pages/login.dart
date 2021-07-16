import 'package:flutter/material.dart';
import 'package:the_bike_kollective/Pages/account.dart';
import 'package:the_bike_kollective/widget/sign_up_widget.dart';
import 'package:the_bike_kollective/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(

        //create a Provider object so the user login data can be used for app
        //state
        create: (context)=> GoogleSignInProvider(),

        //StreamBuilder in this page will monitor any changes in the user login
        //state and show the appropriate page
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder:(context, snapshot){
              final provider = Provider.of<GoogleSignInProvider>(context, listen:false);

              //TODO update this page with correct login page from Michael
              if(snapshot.hasData){
                return Account();
              }

              else {
                return SignUpWidget();
              }
            }
        ),
      )
    );
  }
}
