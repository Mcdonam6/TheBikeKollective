import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinInformation {

  String bikeId;
  LatLng location;
  String bikeType;
  String bikeBrand;
  String bikeModel;
  String bikePicture;

  PinInformation({
    required this.bikeId,
    required this.location,
    required this.bikeType,
    required this.bikeBrand,
    required this.bikeModel,
    required this.bikePicture,
  });
}

