import 'package:flutter/material.dart';
import 'package:the_bike_kollective/Pages/home.dart';
import 'package:the_bike_kollective/Pages/login.dart';


void main() => runApp(MaterialApp(
    //create routes
    routes: {
      '/':(context)=> Login(), //initial route can be updated to test screens
      '/home':(context)=> Home(), //home screen
      '/login':(context)=> Login(), //login screen
    }

));



