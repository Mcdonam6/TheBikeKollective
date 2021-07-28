import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  File? image;
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
    this.image,
    this.latitude,
    this.longitude,
    this.in_use = false,
    this.model,
    this.needs_repair = false,
  ]);

  GeoPoint assembleLocation() {
    return GeoPoint(this.latitude!, this.longitude!);
  }
}
