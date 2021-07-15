import 'package:flutter/material.dart';
import 'package:the_bike_kollective/components/formattedFormInput.dart';

class AddBike extends StatefulWidget {
  @override
  _AddBikeState createState() => _AddBikeState();
}

const agreement = '''Bike Donation Agreement: 

The Bike I am donating is my bike to donate. 
The bike works, and I release interest in the bike after submitting this form.

After donation, this bike belongs to the kollective.''';
// bool _photoAdded = false;

class _AddBikeState extends State<AddBike> {
  final GlobalKey<FormState> _addBikeFormKey = GlobalKey<FormState>();
  Widget bikePhoto = Icon(Icons.add_a_photo);

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
              child: (Container(
                color: Colors.grey,
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.all(30),
                child: bikePhoto,
              )),
            ), //Photo Icon/Add Button
            formattedFormInput(placeholderTxt: 'Bike Name'),
            formattedFormInput(placeholderTxt: 'Bike Type'),
            formattedFormInput(placeholderTxt: 'Bike Details'),
            formattedFormInput(placeholderTxt: 'Lock Combination'),
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
                onPressed: () => {},
                child: Text('Donate Bike'),
              ),
            ), //Submit Button
          ],
        ),
      ),
    );
  }
}

// void _updatePhoto(Widget photo) {
//   // photo = ;
// }
