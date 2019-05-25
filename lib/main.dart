import 'package:flutter/material.dart';
import 'package:storiesbase/home.dart';
void main()  => runApp(StoriesBase(), );
class StoriesBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      title: 'storiesBase',
      home: Home(),
    );
  }
}
