import 'package:flutter/material.dart';
import 'package:the_bike_kollective/Pages/home.dart';
import 'package:the_bike_kollective/Pages/takePicture.dart';
import 'package:the_bike_kollective/Pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_bike_kollective/Pages/gMapView.dart';
import 'package:camera/camera.dart';

Future main() async {
  //Firebase authentication required for Google Authentication login
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(
    MaterialApp(

        //create routes
        routes: {
          '/': (context) =>
              Login(), //initial route can be updated to test screens
          'home': (context) => Home(), //home screen
          'login': (context) => Login(), //login screen
          'takePicture': (context) => TakePicture(camera: firstCamera),
        }),
  );
}
