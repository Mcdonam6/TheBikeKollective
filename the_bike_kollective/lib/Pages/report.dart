import 'package:flutter/material.dart';
import 'package:the_bike_kollective/objects/PinInformation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference bikeData = FirebaseFirestore.instance.collection('bikes');


Future<void> updateBike(bikeId, issue) {
  return bikeData
      .doc(bikeId)
      .update({'has_issue': true, 'issue_type':'$issue'});
}





class Report extends StatelessWidget {

  //initilize with pin information object passed from map screen
  const Report({Key? key, this.passedPin}) : super(key: key);

  //field to hold currentlySelectedPin from map screen
  final PinInformation? passedPin;

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
        child: Column(
          children: [
            //_bikeIssueField(context, bike),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                onPressed: () => {updateBike(passedPin!.bikeId,"repair")},
                child: Text('Needs Repair'),
              ),
            ),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                onPressed: () => {updateBike(passedPin!.bikeId, "missing"),
                  Navigator.pop(context)},
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
