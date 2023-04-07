import 'dart:io';
import 'package:flutter/material.dart';
import './main.dart';
import 'place.dart';
import 'dbhelper.dart';

class PictureScreen extends StatelessWidget {
  final String imagePath;
  final Place place;
  const PictureScreen(this.imagePath, this.place, {super.key});
  @override
  Widget build(BuildContext context) {
    DbHelper helper = DbHelper();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Save picture'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                place.image = imagePath;
                //save image
                helper.insertPlace(place);
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => MainMap());
                Navigator.push(context, route);
              },
            )
          ],
        ),
        body: Image.file(File(imagePath)));
  }
}
