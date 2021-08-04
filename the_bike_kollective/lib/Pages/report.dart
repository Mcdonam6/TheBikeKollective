import 'package:flutter/material.dart';
import 'package:the_bike_kollective/objects/PinInformation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference bikeData = FirebaseFirestore.instance.collection('bikes');


//Function to update bike in firebase with a bike issue
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
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Report Bike Issue"),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    child: Text("Repairs Needed",
                    style: TextStyle(
                      fontSize: 26
                    )),
                    onPressed: () {
                      updateBike(passedPin!.bikeId,"repair");
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    child: Text("Missing",
                    style: TextStyle(
                      fontSize: 26
                    )),
                    onPressed: ()  {
                      updateBike(passedPin!.bikeId, "missing");
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
