import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storiesbase/services/images-service.dart';
import 'package:storiesbase/story-details.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                  ),
                  text: "Home",
                ),
                Tab(icon: Icon(Icons.search), text: "Search"),
                Tab(icon: Icon(Icons.file_download), text: "Downloads"),
                Tab(icon: Icon(Icons.list), text: "More"),
              ],
              unselectedLabelColor: Color(0xff999999),
              labelColor: Colors.white,
              indicatorColor: Colors.transparent),
          body: TabBarView(
            children: [
              HomePage(),
              Center(
                child: Text("Page 2"),
              ),
              Center(
                child: Text("Page 3"),
              ),
              Center(child: Text("Page 4")),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeView();
  }
}

class HomeView extends State<HomePage> {
  var appService = new AppService();
  ScrollController scrollController = new ScrollController();
  final myList = new List();
  bool isLoading = false;

  void fetchData() async {
    var data = await (appService.getJsonData());
    setState(() {
      data.forEach((item) => {myList.add(item)});
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset && isLoading) {
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: appService.getJsonData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          return Container(
            child: ListView.builder(
              itemCount: myList.length + 1,
              controller: scrollController,
              itemBuilder: (BuildContext context, int index) {
                if (index < myList.length) {
                  return makeWidget(myList[index], index);
                }
                if (!isLoading) {
                  isLoading = true;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Widget makeWidget(theList, index) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      height: 320,
      child: Column(
        children: <Widget>[
          new Row(children: <Widget>[
            new Container(
              margin: EdgeInsets.only(left: 10),
              child: new Text( theList["name"],
                textAlign: TextAlign.start,
              ),
            ),
          ]),
          new Container(
            height: 280,
            child: ListView(
                scrollDirection: Axis.horizontal, children: makeContainers(theList)),
          ),
        ],
      ),
    );
  }

  int counter = 0;
  List<Widget> makeContainers(theList) {
    List<GestureDetector> movieList = [];
    for (int i = 0; i < 5; i++) {
      counter++;
      movieList.add(new GestureDetector(
        child: Container(
          margin: EdgeInsets.all(6),
          child: Stack(
            children: <Widget>[
              Container(
                width: 150,
                height: 350.0,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(8.0),
                  child: Image.asset(
                      "lib/assets/" + counter.toString() + ".jpg",
                      fit: BoxFit.fill),
                ),
              ),
              Container(
                height: 300,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(8.0),
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0x00000000),
                        const Color(0x00000000),
                        const Color(0xCC000000),
                      ],
                      stops: [0.0, 0.5, 1.0],
                    )),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      width: 150,
                      child: Text(
                        theList["name"],
                        style: TextStyle(fontSize: 17),
                      )),
                ),
              ),
              Align(
                child: Container(
                  alignment: Alignment.topRight,
                  width: 150,
                  /* margin: EdgeInsets.all(5),*/
                  child: Container(
                      margin: EdgeInsets.only(right: 8, top: 8),
                      width: 45,
                      height: 45,
                      decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87,
                              blurRadius: 6.0,
                            )
                          ],
                          border: Border.all(
                            width: 2.0,
                            style: BorderStyle.solid,
                            color: Colors.red,
                          ),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              "lib/assets/" + counter.toString() + ".jpg",
                            ),
                          ))),
                ),
              ),
            ],
          ),
        ),
        onTap: () => {
              _push(),
            },
      ));
      if (counter == 5) {
        counter = 0;
      }
    }
    return movieList;
  }

  void _push() {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => TimelineStories()));
  }
}
