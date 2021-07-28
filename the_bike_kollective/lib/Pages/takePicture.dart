import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

class TakePicture extends StatefulWidget {
  final CameraDescription camera;

  TakePicture({required this.camera});

  @override
  _PictureState createState() => _PictureState();
}

class _PictureState extends State<TakePicture> {
  late CameraController photoController;
  late Future<void> initializedController;

  @override
  void dispose() {
    photoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    photoController =
        new CameraController(widget.camera, ResolutionPreset.medium);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await initializedController;
            var picFile = await photoController.takePicture();
            Widget newpicture = Image.file(File(picFile.toString()));
            Navigator.pop(context, newpicture);
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.add_photo_alternate),
      ),
    );
  }
}
