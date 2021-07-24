import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MapsPage extends StatefulWidget {

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {

  //Google Maps Controller
  late GoogleMapController myController;

  //set that refreshes with all bike markers
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  //get bike data returned from Firestore and each bike to the bike markers set
  void initMarker(bikeData, bikeId) async {
    var markerIdVal = bikeId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(bikeData['location'].latitude, bikeData['location'].longitude),
        infoWindow: InfoWindow(title: bikeData['biketype'], snippet:bikeData['brand'] )
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


  void initState(){
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
   // //test
   // Set<Marker> getMarker(){
   //   return <Marker>[
   //     Marker(
   //       markerId: MarkerId('Grocery Store'),
   //       position: LatLng(37.7749, -122.4194),
   //       icon: BitmapDescriptor.defaultMarker,
   //       infoWindow: InfoWindow(title: 'Shop')
   //     )
   //   ].toSet();
   // }


    return Scaffold(
      body: GoogleMap(
        // grab all markers to be displayed in the map
        markers: Set<Marker>.of(this.markers.values),
        initialCameraPosition: CameraPosition(
          //TODO update target to be user location
          target: LatLng(37.7749, -122.4194),
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller){
          myController = controller;
        },
      )
    );
  }
}
