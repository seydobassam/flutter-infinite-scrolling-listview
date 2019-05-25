import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storiesbase/content.dart';
import 'package:storiesbase/small_story.dart';
import 'package:after_layout/after_layout.dart';

class Display extends StatefulWidget {
  final doodle;
  final textTheme;

  Display({@required this.doodle, this.textTheme});

  @override
  State<StatefulWidget> createState() {
    return DisplayPage();
  }
}

class DisplayPage extends State<Display> with AfterLayoutMixin<Display> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  background: Hero( tag: widget.doodle.id, child: SmallStory(doodle: widget.doodle, textTheme: widget.textTheme))
              ),
            ),
          ];
        },
        body: Center(
          child: Center(
            child:  Hero(
              tag: widget.doodle.time,
              child: new Material(
                color: Colors.transparent,
                child: Content(),
              ),
            )
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
  }
}
