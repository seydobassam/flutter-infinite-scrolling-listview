import 'package:flutter/material.dart';
import 'package:storiesbase/content.dart';
import 'package:storiesbase/display.dart';
import 'package:storiesbase/small_story.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'data.dart';

class TimelineStories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Stories();
  }
}

class Stories extends State<TimelineStories> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [timelineModel(TimelinePosition.Left)];
    return new Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xff1A355B),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Hannover"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.photo),
                  text: "Stories",
                ),
                Tab(icon: Icon(Icons.map), text: "Map")
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[PageView(children: pages), Text("name")],
          ),
        ),
      ),
    );
  }

  timelineModel(TimelinePosition position) => Timeline.builder(itemBuilder: centerTimelineBuilder, lineColor: Colors.white, itemCount: doodles.length, physics: position == TimelinePosition.Left ? ClampingScrollPhysics() : BouncingScrollPhysics(), position: position);
  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = doodles[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
        Container(
          child: GestureDetector(
              child: Card(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    children: <Widget>[
                      Hero(
                          tag: doodle.id,
                          child: SmallStory(
                              doodle: doodle, textTheme: textTheme)),
                      Hero(
                        tag: doodle.time,
                        child: new Material(
                            color: Colors.transparent, child: Content()),
                      )
                    ],
                  )),
              onTap: () => {
                Navigator.of(context).push(
                  PageRouteBuilder<Null>(
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return AnimatedBuilder(
                            animation: animation,
                            builder:
                                (BuildContext context, Widget child) {
                              return Opacity(
                                opacity: 1,
                                child: Display(
                                  doodle: doodle,
                                  textTheme: textTheme,
                                ),
                              );
                            });
                      },
                      transitionDuration:
                      Duration(milliseconds: 400)),
                ),
              }),
        ),
        isLast: true,
        iconBackground: doodle.iconBackground,
        icon: doodle.icon);
  }
}
