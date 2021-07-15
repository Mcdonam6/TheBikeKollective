import 'package:flutter/material.dart';
import 'package:the_bike_kollective/Pages/findBike.dart';
import 'package:the_bike_kollective/Pages/addBike.dart';
import 'package:the_bike_kollective/Pages/reportIssue.dart';

import 'package:the_bike_kollective/Pages/account.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('The Bike Kollective'),
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.pedal_bike)),
            Tab(icon: Icon(Icons.add)),
            Tab(icon: Icon(Icons.build)),
          ]),
        ),
        body: TabBarView(
          children: [
            Account(),
            FindBike(),
            AddBike(),
            ReportIssue(),
          ],
        ),
      ),
    );
  }
}
