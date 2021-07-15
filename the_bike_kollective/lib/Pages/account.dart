import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Username Placeholder'),
            Text('FirstName LastName Placeholder'),
            Text('Email Placeholder'),
            ElevatedButton(onPressed: _logout, child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}

void _logout() {
  //Stub for Logout Function
}
