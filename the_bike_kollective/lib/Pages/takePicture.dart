import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

class TakePicture extends StatefulWidget {
  var picture;
  final cameras;

  TakePicture({this.cameras, this.picture});

  @override
  _PictureState createState() =>
      _PictureState(picture: picture, cameras: cameras);
}

class _PictureState extends State<TakePicture> {
  late CameraController photoController;
  late Future<void> initializedController;
  final cameras;
  var picture;

  _PictureState({this.picture, this.cameras});

  @override
  void dispose() {
    photoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    photoController =
        new CameraController(widget.cameras, ResolutionPreset.medium);
    initializedController = photoController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Bike Picture:'),
      ),
      body: FutureBuilder<void>(
        future: initializedController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(photoController);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await initializedController;
            var newpicture = await photoController.takePicture();
            Navigator.pop(context);
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
