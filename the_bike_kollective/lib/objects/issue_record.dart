import 'package:flutter/material.dart';

class IssueRecord {
  final String bikeID;
  final List<String> issueType = [
    'Bike Missing',
    'Bike chain fell off or Broken',
    'Bike Lock combination not working',
    'Flat Tire(s)',
    'Other Issue',
  ];
  final String issueDetails;

  IssueRecord(
    this.bikeID,
    this.issueDetails,
  );
}
