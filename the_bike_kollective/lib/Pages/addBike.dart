import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'package:the_bike_kollective/objects/bike.dart';

class AddBike extends StatefulWidget {
  @override
  _AddBikeState createState() => _AddBikeState();
}

const agreement = '''Bike Donation Agreement: 

The Bike I am donating is my bike to donate. 
The bike works, and I release interest in the bike after submitting this form.

After donation, this bike belongs to the kollective.''';

class _AddBikeState extends State<AddBike> {
  final GlobalKey<FormState> _addBikeFormKey = GlobalKey<FormState>();
  Widget? bikePhoto;
  Bike addition = new Bike();

  @override
  void initState() {
    super.initState();
    bikePhoto = Container(
      color: Colors.grey,
      key: UniqueKey(),
      child: Icon(Icons.add_a_photo),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            ("Add a Bike"),
          ),
        ),
      ),
      body: Form(
        key: _addBikeFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                key: UniqueKey(),
                height: screenSize * .4,
                child: GestureDetector(
                  onTap: () {
                    _updatePhoto(addition, context).then(
                      (value) => setState(() {
                        if (addition.image != null) {
                          bikePhoto = Container(
                            key: UniqueKey(),
                            child: Image.file(addition.image!),
                          );
                        }
                      }),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.all(30),
                    child: bikePhoto,
                  ),
                ), //Photo Icon/Add Button
              ),
              _bikeTypeField(addition, screenSize * .075),
              _bikeBrandField(addition, screenSize * .075),
              _bikeModelField(addition, screenSize * .075),
              _bikeColorField(addition, screenSize * .075),
              _bikeCombinationField(addition, screenSize * .075),
              Container(
                height: screenSize * .2,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: SingleChildScrollView(
                    child: Text(
                      agreement,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                height: screenSize * .05,
                child: ElevatedButton(
                  onPressed: () {
                    if (_addBikeFormKey.currentState!.validate()) {
                      _addBikeFormKey.currentState!.save();
                      _uploadNewBike(addition);
                      Navigator.of(context).popAndPushNamed('home');
                    }
                  },
                  child: Text('Donate Bike'),
                ),
              ), //Submit Button
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> _uploadPicture(Bike addition) async {
  Reference storageInstance = FirebaseStorage.instance
      .ref()
      .child('_bikeImages')
      .child('${DateTime.now()}.jpg');
  UploadTask uploadTask = storageInstance.putFile(addition.image!);
  await uploadTask;
  return storageInstance.getDownloadURL();
}

//Location Setting for bike object
Future<void> _setLocation(Bike addition) async {
  var bikeLocation = new Location();
  var locationEnabled = await bikeLocation.serviceEnabled();
  if (!locationEnabled) {
    locationEnabled = await bikeLocation.requestService();
    if (!locationEnabled) {
      print("Access denied to location service");
      return;
    }
  }
  var currentLocation = await bikeLocation.getLocation();
  addition.latitude = currentLocation.latitude;
  addition.longitude = currentLocation.longitude;
}

// Database and cloud storage Upload Functions
Future<void> _uploadNewBike(Bike addition) async {
  String imagePath = await _uploadPicture(addition);
  await _setLocation(addition);
  GeoPoint bikeLocation = addition.assembleLocation();
  await FirebaseFirestore.instance.collection("bikes").add({
    'biketype': addition.biketype,
    'brand': addition.brand,
    'color': addition.color,
    'combination': addition.combination,
    'image_path': imagePath,
    'in_use': false,
    'location': bikeLocation,
    'model': addition.model,
    'needs_repair': false
  });
}

Future<void> _updatePhoto(Bike addition, BuildContext context) async {
  File? pic = await Navigator.pushNamed(context, 'takePicture') as File?;
  addition.image = pic;
}

// Form Data Field Widgets

Widget _bikeTypeField(Bike addition, double heightVal) {
  return Container(
    height: heightVal,
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    child: TextFormField(
      onSaved: (value) {
        addition.biketype = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Bike Type';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Bike Type',
      ),
    ),
  );
}

Widget _bikeBrandField(Bike addition, double heightVal) {
  return Container(
    height: heightVal,
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    child: TextFormField(
      onSaved: (value) {
        addition.brand = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Brand';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Bike Brand',
      ),
    ),
  );
}

Widget _bikeColorField(Bike addition, double heightVal) {
  return Container(
    height: heightVal,
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    child: TextFormField(
      onSaved: (value) {
        addition.color = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Color';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Bike Color',
      ),
    ),
  );
}

Widget _bikeModelField(Bike addition, double heightVal) {
  return Container(
    height: heightVal,
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    child: TextFormField(
      onSaved: (value) {
        addition.model = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Model';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Bike Model',
      ),
    ),
  );
}

Widget _bikeCombinationField(Bike addition, double heightVal) {
  return Container(
    height: heightVal,
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    child: TextFormField(
      onSaved: (value) {
        addition.combination = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Lock Combination';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Lock Combination',
      ),
    ),
  );
}
