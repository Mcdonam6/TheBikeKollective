import 'package:geopoint/geopoint.dart';
import 'package:latlong2/latlong.dart';

class Bike {
  final typesOfBikes = [
    'Mountain Bike',
    'BMX',
    'Beach Cruiser',
    'Road Bike',
  ];

  String? biketype;
  String? brand;
  String? color;
  String? image_path;
  String? model;
  String? combination;
  double? latitude;
  double? longitude;
  bool needs_repair;
  bool in_use;

  Bike([
    this.biketype,
    this.brand,
    this.color,
    this.combination,
    this.image_path,
    this.latitude,
    this.longitude,
    this.in_use = false,
    this.model,
    this.needs_repair = false,
  ]);

  GeoPoint assembleLocation() {
    return GeoPoint.fromLatLng(point: LatLng(this.latitude!, this.longitude!));
  }
}
