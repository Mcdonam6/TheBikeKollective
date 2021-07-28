import 'package:geopoint/geopoint.dart';
import 'package:latlong2/latlong.dart';

class Bike {
  final typesOfBikes = [
    'Mountain Bike',
    'BMX',
    'Beach Cruiser',
    'Road Bike',
  ];

  final String biketype;
  final String brand;
  final String color;
  final String image_path;
  final String model;
  double latitude;
  double longitude;
  bool needs_repair;
  bool in_use;

  Bike(
    this.biketype,
    this.brand,
    this.color,
    this.image_path,
    this.latitude,
    this.longitude,
    this.in_use,
    this.model,
    this.needs_repair,
  );

  GeoPoint assembleLocation() {
    return GeoPoint.fromLatLng(point: LatLng(this.latitude, this.longitude));
  }
}
