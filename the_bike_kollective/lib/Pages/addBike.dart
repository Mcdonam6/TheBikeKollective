import 'package:flutter/material.dart';
import 'package:the_bike_kollective/widget/formattedFormInput.dart';
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

  @override
  void initState() {
    super.initState();
    bikePhoto = Container(key: UniqueKey(), child: Icon(Icons.add_a_photo));
  }

  @override
  Widget build(BuildContext context) {
    // formFields = addFields(context, _addBikeFormKey, bikePhoto);
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
            formattedFormInput(
              flexVal: 1,
              placeholderTxt: 'Bike Name',
            ),
            formattedFormInput(flexVal: 1, placeholderTxt: 'Bike Type'),
            formattedFormInput(flexVal: 1, placeholderTxt: 'Bike Details'),
            formattedFormInput(flexVal: 1, placeholderTxt: 'Lock Combination'),
            Flexible(
                flex: 3,
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      agreement,
                      textAlign: TextAlign.center,
                    ))),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  if (_addBikeFormKey.currentState!.validate()) {
                    _addBikeFormKey.currentState!.save();
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

// Bike _saveForm(List<Widget> formFields) {
//   return   Bike(
//     formFields,
//     brand,
//     color,
//     image_path,
//     latitude,
//     longitude,
//     in_use: false,
//     model,
//     needs_repair,
//   );
// }

void _uploadNewBike(Bike addition) {
  final bikeTable = FirebaseFirestore.instance.collection('bikes').add({
    'biketype': addition.biketype,
    'brand': addition.brand,
    'color': addition.color,
    'imagepath': addition.image_path,
    'in_use': false,
    'location': addition.assembleLocation(),
    'model': addition.model,
    'needs_repair': false
  });
}

// List<Widget> addFields(BuildContext context,
//     GlobalKey<FormState> _addBikeFormKey, Widget bikePhoto) {
//    ;
// }
