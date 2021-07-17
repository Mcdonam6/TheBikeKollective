import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:the_bike_kollective/provider/google_sign_in.dart';

class LoggedInWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      alignment: Alignment.center,
      //color: Colors.blueGrey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text('Logged In'),
          SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage(user!.photoURL!),
          ),
          SizedBox(height:8),
          Text('Name ' + user!.displayName!),
          SizedBox(height:8),
          Text('Email ' + user!.email!),
          ElevatedButton(onPressed: () {
            final provider = Provider.of<GoogleSignInProvider>(context, listen:false);
            provider.logout();
          },
              child: Text("Logout")),

        ]

      )
    );
  }
}
