import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:the_bike_kollective/utilities/user_geospatial.dart';
import 'activeRide.dart';
import 'package:the_bike_kollective/Pages/report.dart';
import 'package:the_bike_kollective/objects/PinInformation.dart';



class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  //Google Maps Controller
  late GoogleMapController myController;

  //get user location
  Location location = new Location();

  //set that refreshes with all bike markers
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  //Google Maps custom marker
  late BitmapDescriptor bikeIcon;

  //define initial marker pill location to be off the screen
  double pinPillPosition = -200;

  //create a currently selected Pin object which will be displayed in the Pill
  PinInformation currentlySelectedPin = PinInformation(

      bikeId: "",
      location: LatLng(0, 0),
      bikeType: "",
      bikeBrand: "",
      bikeModel: "",
      bikePicture: "",
      );


  //function used by marker on tap to populate a pill to be the currently
  //selected marker
  void setSelectedPin(String bikeId, LatLng location, String bikeType, String bikeBrand,
      String bikeModel, String bikePicture) {
        currentlySelectedPin = PinInformation(
          bikeId: bikeId,
          location: location,
          bikeType: bikeType,
          bikeBrand: bikeBrand,
          bikeModel: bikeModel,
          bikePicture: bikePicture);
  }

  //set custom google marker
  void setSourceIcon() async {
    bikeIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 10.5), 'assets/bikeIcon2.png');
  }

  //get bike data returned from Firestore and each bike to the bike markers set
  void initMarker(bikeData, bikeId) async {
    var markerIdVal = bikeId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      icon: bikeIcon,
      position:
          LatLng(bikeData['location'].latitude, bikeData['location'].longitude),
      infoWindow:
          InfoWindow(title: bikeData['biketype'], snippet: bikeData['brand']),
      onTap: () {
        setState(() {
          setSelectedPin(
              bikeId,

              LatLng(bikeData['location'].latitude, bikeData['location'].longitude),
              bikeData['biketype'],
              bikeData['brand'],
              bikeData['model'],
              bikeData['image_path']);
          pinPillPosition = 100;
        });
      },
    );

    setState(() {
      markers[markerId] =
          marker; //adding anew marker ID and marker object to the markers set
    });
  }

  //Grab all data for bikes from Firestore and pass to initMarker to add
  //bike data to marker set
  getMarkerData() async {
    FirebaseFirestore.instance.collection('bikes').get().then((bikeData) {
      if (bikeData.docs.isNotEmpty) {
        for (int i = 0; i < bikeData.docs.length; i++) {
          //check if bike is in use

          if (bikeData.docs[i]["in_use"] != true && bikeData.docs[i]["has_issue"] != true){
            initMarker(bikeData.docs[i].data(), bikeData.docs[i].id);

          }
        }
      }
    });
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

  //override initial state to set markers and set custom pin icons
  void initState() {
    getMarkerData();
    super.initState();
    setSourceIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack (
        children: <Widget> [
          GoogleMap(
            // grab all markers to be displayed in the map
            markers: Set<Marker>.of(this.markers.values),
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 14.0,
            ),
            onMapCreated:_onMapCreated,
            myLocationEnabled: true,
            onTap: (LatLng location) {
              setState(() {
                getMarkerData();
                pinPillPosition = -200;
              });
            }
          ),
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          onTap: (LatLng location) {
            setState(() {
              pinPillPosition = -200;
            });
          }),
      AnimatedPositioned(
          bottom: pinPillPosition,
          right: 0,
          left: 0,
          duration: Duration(milliseconds: 200),
          // wrap it inside an Alignment widget to force it to be
          // aligned at the bottom of the screen
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.all(20),
                  height: 125,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 20,
                            offset: Offset.zero,
                            color: Colors.grey.withOpacity(0.5))
                      ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 100,
                          height: 100,
                          child: ClipOval(
                            child: Image(
                              image: NetworkImage(
                                  currentlySelectedPin.bikePicture),
                              //image: AssetImage('assets/bikeIcon1.png'),
                              fit: BoxFit.cover,
                            ),
                          )),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      currentlySelectedPin.bikeType,
                                    ),
                                    Text(
                                        'Brand: ${currentlySelectedPin.bikeBrand}',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    Text(
                                        'Model: ${currentlySelectedPin.bikeModel}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        )),
                                    Container(
                                        width: 100,
                                        height: 30,
                                        child: ElevatedButton.icon(
                                          icon:
                                              Icon(Icons.error_outline_rounded),
                                          label: Text("Report",
                                          style: TextStyle(
                                            fontSize: 12
                                          )
                                          ),
                                          onPressed: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => Report(passedPin:currentlySelectedPin),
                                            )
                                            );
                                          }, 
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.red)),
                                        )),
                                  ]))),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: _checkoutButton(currentlySelectedPin),
                      ),
                    ],
                  )) // end of Container
              ) // end of Align
          )
    ]));
  }

  Widget _checkoutButton(PinInformation bike) {
    if (UserLocation.distanceToBike(bike) < 1) {
      return FloatingActionButton(
        child: Text('Ride'),
        onPressed: () async {
          bikeData.doc(bike.bikeId).update({'in_use': true});
          GeoPoint newLocation = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActiveRide(passedPin: currentlySelectedPin),
            ),
          );
          bikeData
              .doc(bike.bikeId)
              .update({'in_use': false, 'location': newLocation});
          setState(() {
            getMarkerData();
            pinPillPosition = -200;
            _animateToUser();
          });
        },
      );
    } else {
      return FloatingActionButton(
        child: Text(
          'Out of Range',
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          setState(() {});
        },
        tooltip: 'Bike too far away, Approach Bike to Ride',
        backgroundColor: Colors.grey,
      );
    }
  }
}
