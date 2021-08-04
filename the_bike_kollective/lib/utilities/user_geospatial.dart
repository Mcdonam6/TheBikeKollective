import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:the_bike_kollective/objects/PinInformation.dart';

class UserLocation {
  static Location _user = new Location();
  static Stream<LocationData>? _locationStream;
  static Geoflutterfire? _geo = Geoflutterfire();
  static LocationData? _initSpot;
  static GeoFirePoint? _userLocation;
  static UserLocation? _instance;

  UserLocation._();

  factory UserLocation.getInstance() {
    assert(_instance != null);
    return _instance!;
  }

  static Future initialize() async {
    _initSpot = await _user.getLocation();
    _userLocation = _geo!.point(
        latitude: _initSpot!.latitude!, longitude: _initSpot!.longitude!);
    _locationStream = _user.onLocationChanged;
    _locationStream!.listen((data) {
      _userLocation =
          _geo!.point(latitude: data.latitude!, longitude: data.longitude!);
    });
  }

  static distanceToBike(PinInformation target) {
    return _userLocation!.distance(
        lat: target.location.latitude, lng: target.location.longitude);
  }

  static Future<GeoPoint> currentGeoPoint() async {
    _initSpot = await _user.getLocation();
    return GeoPoint(_initSpot!.latitude!, _initSpot!.longitude!);
  }
}
