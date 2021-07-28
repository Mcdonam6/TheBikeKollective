import 'package:flutter/material.dart';
import 'package:the_bike_kollective/Pages/gMapView.dart';

class FindBike extends StatefulWidget {
  @override
  _FindBikeState createState() => _FindBikeState();
}

class _FindBikeState extends State<FindBike> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            ("Find a Bike"),
          ),
        ),
      ),
      body: MapsPage()
    );
  }
}
