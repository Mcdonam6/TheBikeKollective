import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:the_bike_kollective/objects/PinInformation.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:the_bike_kollective/utilities/user_geospatial.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

//CollectionReference bikeData = FirebaseFirestore.instance.collection('bikes');

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
  StopWatchTimer _rideTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    onChange: (value) => print('onChange $value'),
  );
  String _rideTime = "";

  @override
  initState() {
    super.initState();
    _rideTimer.setPresetHoursTime(8);
    _rideTimer.onExecute.add(StopWatchExecute.start);
  }

  @override
  void dispose() async {
    super.dispose();
    await _rideTimer.dispose();
  }

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

  Widget _timerOrWarning() {
    if (_rideTimer.rawTime.value > 0) {
      return Center(
        child: StreamBuilder<int>(
            stream: _rideTimer.rawTime,
            initialData: _rideTimer.rawTime.value,
            builder: (context, snapshot) {
              _rideTime = StopWatchTimer.getDisplayTime(
                snapshot.data!,
                hours: true,
                minute: true,
                milliSecond: false,
                second: true,
              );
              return Text(_rideTime + ' Remaining',
                  textAlign: TextAlign.center);
            }),
      );
    } else {
      return Text('Warning: 8 hr Time limit exceded, please check bike in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _timerOrWarning(),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 17,
            child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.7749, -122.4194),
                  zoom: 14.0,
                ),
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                onTap: (LatLng location) {
                  setState(() {});
                }),
          ),
          Flexible(
            flex: 3,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: ElevatedButton(
                  child: Text('End Ride', style: TextStyle(fontSize: 30)),
                  onPressed: () async {
                    if (await confirm(
                      context,
                      title: Text('Bike Check In'),
                      content: Text('Are you Finished Riding?'),
                      textOK: Text('Yes, Bike is Locked where I am now'),
                      textCancel: Text('No, I am Still Riding'),
                    )) {
                      Navigator.pop(context, UserLocation.currentGeoPoint());
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
