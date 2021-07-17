//Page/Widget to be displayed for a user to login

import 'package:flutter/material.dart';
import 'package:the_bike_kollective/widget/google_sign_up_button_widget.dart';

class SignUpWidget extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return buildSignUp();
  }

  Widget buildSignUp(){
    return Column(
      children:[
        Spacer(),
        Align(
          alignment: Alignment.centerLeft,
          child:Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: 175,
            child: Text('Welcome to Bike Kollective',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              )
            )
          )
        ),
        Spacer(),
        SizedBox(height:12),
        GoogleSignUpWidget(), //button to get logged in
        Text('Login to continue',
        style: TextStyle(fontSize: 16),
        ),
        Spacer(),
      ]
    );
  }
}
