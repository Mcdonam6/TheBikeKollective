import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void addBikeButton() {
    //Stub for Adding bike navigation
  }

  void findBikeButton() {
    //Stub for Find Bike Navigation
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('The Bike Kollective'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 5,
              child: FractionallySizedBox(
                heightFactor: .8,
                widthFactor: .8,
                child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, double.infinity))),
                  child: Stack(
                    children: [
                      Align(
                        child: Icon(Icons.add_rounded),
                        alignment: Alignment(0, -.2),
                      ),
                      Align(
                        child: Text('Add Bike'),
                        alignment: Alignment(0, .2),
                      ),
                    ],
                  ),
                  onPressed: addBikeButton,
                ),
              ),
            ),
            Flexible(flex: 1, child: Container()),
            Flexible(
              flex: 5,
              child: FractionallySizedBox(
                heightFactor: .8,
                widthFactor: .8,
                child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, double.infinity))),
                  child: Stack(
                    children: [
                      Align(
                        child: Icon(Icons.pedal_bike),
                        alignment: Alignment(0, -.2),
                      ),
                      Align(
                        child: Text('Find Bike'),
                        alignment: Alignment(0, .2),
                      ),
                    ],
                  ),
                  onPressed: addBikeButton,
                ),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
