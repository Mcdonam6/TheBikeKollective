import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:the_bike_kollective/objects/pins.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:the_bike_kollective/utilities/user_geospatial.dart';

CollectionReference bikeData = FirebaseFirestore.instance.collection('bikes');

class ActiveRide extends StatefulWidget {
  //initilize with pin information object passed from map screen
  const ActiveRide({Key? key, this.passedPin}) : super(key: key);

  //field to hold currentlySelectedPin from map screen
  final PinInformation? passedPin;
  @override
  _RideState createState() => _RideState();
}

class _RideState extends State<ActiveRide> {
  late GoogleMapController myController;
  Location location = new Location();

  //function that will execute when map view is created
  _onMapCreated(GoogleMapController controller) {
    setState(() {
      myController = controller;
      _animateToUser();
    });
  }

  //function get user location and then zoom to location when the map is first open
  _animateToUser() async {
    var pos = await location.getLocation();
    print(pos);
    myController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude!, pos.longitude!),
      zoom: 17.0,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            ("On a Ride!"),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(37.7749, -122.4194),
            zoom: 14.0,
          ),
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          onTap: (LatLng location) {
            setState(() {});
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (await confirm(
            context,
            title: Text('Bike Check In'),
            content: Text('Are you Finished Riding?'),
            textOK: Text('Yes, Bike is Locked where I am now'),
            textCancel: Text('No, I am Still Riding'),
          )) {
            Navigator.pop(context, UserLocation.currentGeoPoint);
          }
          ;
        },
        label: Text('End Ride'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
