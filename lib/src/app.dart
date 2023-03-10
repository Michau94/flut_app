// Import flutter library

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import './models/image_model.dart';
import 'dart:convert';
import 'widgets/image_list.dart';

// Create class custom widget
// must extend Stateless widget base class

class App extends StatefulWidget {
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter++;
    var response = await get(
        Uri.parse('https://jsonplaceholder.typicode.com/photos/$counter'));
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    setState(() {
      images.add(imageModel);
    });
  }

// Build method that returns what widget will show
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Let\'s see Images!'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            fetchImage();
          },
          child: const Icon(Icons.add),
        ),
        body: ImageList(images),
      ),
    );
  }
}
