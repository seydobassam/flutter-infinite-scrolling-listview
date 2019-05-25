import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SmallStory extends StatefulWidget {
  final doodle;
  final textTheme;

  SmallStory({@required this.doodle, this.textTheme});

  @override
  State<StatefulWidget> createState() {
    return new StoryDetails(doodle: doodle, textTheme: textTheme);
  }
}

class StoryDetails extends State<SmallStory> {
  final doodle;
  final textTheme;

  StoryDetails({@required this.doodle, this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
        child:  FadeInImage.assetNetwork(placeholder: "assets/loading.gif", image: doodle.doodle, fit: BoxFit.fill)/*Image.network(doodle.doodle, fit: BoxFit.fill, width: 200, height: 100,),*/
    );
  }
}
