// ignore_for_file: library_private_types_in_public_api, no_logic_in_create_state, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hw8_kac/picture_screen.dart';
import 'package:hw8_kac/place.dart';

class CameraScreen extends StatefulWidget {
  final Place place;
  const CameraScreen(this.place, {super.key});
  @override
  _CameraScreenState createState() => _CameraScreenState(place);
}

class _CameraScreenState extends State<CameraScreen> {
  final Place place;
  late CameraController _controller;
  late List<CameraDescription> cameras;
  late CameraDescription camera;
  late Widget cameraPreview;
  late Image image;

  _CameraScreenState(this.place);

  Future setCamera() async {
    cameras = await availableCameras();
    camera = cameras.first;
  }

  @override
  void initState() {
    setCamera().then((_) {
      _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        camera,
        // Define the resolution to use.
        ResolutionPreset.medium,
      );
      _controller.initialize().then((snapshot) {
        cameraPreview = Center(child: CameraPreview(_controller));
        setState(() {
          cameraPreview = cameraPreview;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Take Picture'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                final path = join(
                  // Store the picture in the temp directory.
                  // Find the temp directory using the `path_provider` plugin.
                  (await getTemporaryDirectory()).path,
                  '${DateTime.now()}.png',
                );
                // Attempt to take a picture and log where it's been saved.
                await _controller.takePicture();
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => PictureScreen(path, place));
                Navigator.push(context, route);
              },
            )
          ],
        ),
        body: Container(
          child: cameraPreview,
        ));
  }
}
