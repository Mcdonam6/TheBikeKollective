import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_bike_kollective/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            ("Account"),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
                child: Text("Logout")),
          ],
        ),
      ),
    );
  }
}
