
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Content extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContentPage();
  }
}

class ContentPage extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Text(
        "title",
        style: new TextStyle(
            fontSize: 30.0
        ),
      ),
    );
  }

}