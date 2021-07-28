import 'package:flutter/material.dart';
import 'package:the_bike_kollective/objects/bike.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<Widget> formFields = [];
  Bike addition = new Bike();

  @override
  void initState() {
    super.initState();
    bikePhoto = Container(key: UniqueKey(), child: Icon(Icons.add_a_photo));
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Flexible(
              flex: 6,
              child: GestureDetector(
                onTap: () {
                  _updatePhoto(bikePhoto, context);
                  setState(() {});
                },
                child: Container(
                  color: Colors.grey,
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.all(30),
                  child: bikePhoto,
                ),
              ), //Photo Icon/Add Button
            ),
            _bikeTypeField(addition),
            _bikeBrandField(addition),
            _bikeModelField(addition),
            _bikeColorField(addition),
            _bikeCombinationField(addition),
            Flexible(
              flex: 3,
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
            Flexible(
              flex: 1,
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
    );
  }
}

Future<void> _updatePhoto(Widget? bikePhoto, BuildContext context) async {
  bikePhoto = Container(
      key: UniqueKey(),
      child: await Navigator.pushNamed(context, 'takePicture') as Widget);
}

Future<void> _uploadNewBike(Bike addition) async {
  await FirebaseFirestore.instance.collection("bikes").add({
    'biketype': addition.biketype,
    'brand': addition.brand,
    'color': addition.color,
    //'imagepath': addition.image_path,
    'in_use': false,
    //'location': addition.assembleLocation(),
    'model': addition.model,
    'needs_repair': false
  });
}

Widget _bikeTypeField(Bike addition) {
  return Flexible(
    flex: 1,
    child: Container(
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
    ),
  );
}

Widget _bikeBrandField(Bike addition) {
  return Flexible(
    flex: 1,
    child: Container(
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
    ),
  );
}

Widget _bikeColorField(Bike addition) {
  return Flexible(
    flex: 1,
    child: Container(
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
    ),
  );
}

Widget _bikeModelField(Bike addition) {
  return Flexible(
    flex: 1,
    child: Container(
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
    ),
  );
}

Widget _bikeCombinationField(Bike addition) {
  return Flexible(
    flex: 1,
    child: Container(
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
    ),
  );
}
