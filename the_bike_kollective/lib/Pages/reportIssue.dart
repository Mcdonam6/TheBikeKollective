import 'package:flutter/material.dart';
import 'package:the_bike_kollective/Pages/gMapView.dart';
import 'package:the_bike_kollective/objects/bike.dart';
import 'package:the_bike_kollective/objects/PinInformation.dart';

class ReportIssue extends StatefulWidget {

  //initilize with pin information object passed from map screen
  const ReportIssue({Key? key,  this.passedPin}) : super(key: key);
  //field to hold currentlySelectedPin from map screen
  final PinInformation? passedPin;

  @override
  _ReportIssueState createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  final GlobalKey<FormState> _reportIssueKey = GlobalKey<FormState>();
  var bike = Bike();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            ("Report Bike Issue"),
          ),
        ),
      ),
      body: Form(
        key: _reportIssueKey,
        child: Column(
          children: [
            //_bikeIssueField(context, bike),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                onPressed: () => {},
                child: Text('Report Issue'),
              ),
            ),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                onPressed: () => {},
                child: Text('Bike Missing'),
              ),
            ),
            //Submit Button
          ],
        ),
      ),
    );
  }
}

// Widget _bikeIssueField(BuildContext context, Bike bikeID) {
//   return Container(
//     height: MediaQuery.of(context).size.height * .5,
//     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//     child: TextFormField(
//       onSaved: (value) {
//         bikeID.needs_repair = false;
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please Enter Issue Details';
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Issue Details',
//       ),
//     ),
//   );
// }
