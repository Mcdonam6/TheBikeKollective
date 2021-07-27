import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';



//information to be displayed in marker pill for a bike
class PinInformation {

  //TODO add all items that are to be displayed in the marker pill
  LatLng location;
  String bikeType;
  String bikePicture;

  PinInformation({
    required this.location,
    required this.bikeType,
    required this.bikePicture,

  });
}


class MapsPage extends StatefulWidget {

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {

  //Google Maps Controller
  late GoogleMapController myController;


  //set that refreshes with all bike markers
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  //get user location
  Location location = new Location();

  //define initial marker pill location to be off the screen
  double pinPillPosition = -200;

  //create a currently selected Pin object which will be displayed in the Pill
  PinInformation currentlySelectedPin = PinInformation(
      location: LatLng(0, 0),
      bikeType: "",
      bikePicture: "",
      );

  late PinInformation sourcePinInfo;


  //function used by marker on tap to populate a pill to be the currently
  //selected marker
  void setSelectedPin(LatLng location, String bikeType, String bikePicture ){
    currentlySelectedPin = PinInformation(
        location: location,
        bikeType: bikeType,
        bikePicture: bikePicture);
  }

  //get bike data returned from Firestore and each bike to the bike markers set
  void initMarker(bikeData, bikeId) async {

    var markerIdVal = bikeId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(bikeData['location'].latitude, bikeData['location'].longitude),
        infoWindow: InfoWindow(title: bikeData['biketype'], snippet:bikeData['brand']),
      onTap: () {
        setState(() {
          setSelectedPin(
              LatLng(bikeData['location'].latitude, bikeData['location'].longitude),
              bikeData['biketype'],
              bikeData['image_path']);
          pinPillPosition = 100;
        });
      },
    );

    setState(() {
      markers[markerId] = marker; //adding anew marker ID and marker object to the markers set
    });


  }


  //Grab all data for bikes from Firestore and pass to initMarker to add
  //bike data to marker set
  getMarkerData() async {
    FirebaseFirestore.instance.collection('bikes').get().then((bikeData) {
      if(bikeData.docs.isNotEmpty){
        for(int i = 0; i < bikeData.docs.length; i ++){
          //check if bike is in use
          print(bikeData.docs[i]["color"]);
          print(bikeData.docs[i]["in_use"]);

          if (bikeData.docs[i]["in_use"] != true && bikeData.docs[i]["needs_repair"] != true){
            initMarker(bikeData.docs[i].data(), bikeData.docs[i].id);
          }

        }
      }
    });
  }



  //function that will execute when map view is created
  _onMapCreated(GoogleMapController controller){
    setState(() {
      //getMarkerData();
      myController = controller;
      _animateToUser();
    });
  }


  //override initial state method to display all markers
  void initState(){
    getMarkerData();
    super.initState();

  }

  //function get user location and then zoom to location when the map is first open
  _animateToUser() async {
    var pos = await location.getLocation();
    print(pos);
    myController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude!, pos.longitude!),
          zoom: 17.0,
        )
    )
    );
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
                pinPillPosition = -200;
              });
            }
          ),
          AnimatedPositioned(
              bottom: pinPillPosition, right: 0, left: 0,
              duration: Duration(milliseconds: 200),
              // wrap it inside an Alignment widget to force it to be
              // aligned at the bottom of the screen
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: EdgeInsets.all(20),
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                blurRadius: 20,
                                offset: Offset.zero,
                                color: Colors.grey.withOpacity(0.5)
                            )]
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 100, height: 100,
                            child: ClipOval(
                              child: 
                                Image(
                                  image: NetworkImage(currentlySelectedPin.bikePicture),
                                  fit: BoxFit.cover,
                                ),
                            )
                          ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      currentlySelectedPin.bikeType,
                                      style: TextStyle(
                                          //color: currentlySelectedPin.labelColor
                                      )
                                    ),
                                    Text(
                                      'Latitude: ${currentlySelectedPin.location.latitude.toString()}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey
                                      )
                                    ),
                                    Text(
                                      'Longitude: ${currentlySelectedPin.location.longitude.toString()}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      )

                                    ),
                                  ])
                            )
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child:FloatingActionButton(
                              child:Text('Ride'),
                              onPressed: () {  },)
                          ),
                        ],
                      )
                  )  // end of Container
              )  // end of Align
          )
        ]
      )
    );
  }
}
