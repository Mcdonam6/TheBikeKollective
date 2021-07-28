import 'package:flutter/material.dart';

class ReportIssue extends StatefulWidget {
  @override
  _ReportIssueState createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  final GlobalKey<FormState> _reportIssueKey = GlobalKey<FormState>();

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
            // formattedFormInput(flexVal: 1, placeholderTxt: 'Bike Name'),
            // //dropdown here
            // formattedFormInput(flexVal: 4, placeholderTxt: 'Issue Details'),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                onPressed: () => {},
                child: Text('Report Issue'),
              ),
            ), //Submit Button
          ],
        ),
      ),
    );
  }
}
