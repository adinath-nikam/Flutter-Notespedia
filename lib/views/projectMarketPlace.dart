import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notespedia/models/models.dart';
import 'package:notespedia/views/appBar.dart';

class projectMarketPlace extends StatefulWidget {
  @override
  _projectMarketPlaceState createState() => _projectMarketPlaceState();
}

class _projectMarketPlaceState extends State<projectMarketPlace>
    with AutomaticKeepAliveClientMixin<projectMarketPlace> {
  @override
  bool get wantKeepAlive => true;
  List<CarouselData> projectCarouselModelList = [];

  List<projectDataModel> projectDataModelList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: appBar(),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child("Notespedia/CAROUSELS/PROJECTCAROUSELDATA")
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        !snapshot.hasError &&
                        snapshot.data.snapshot.value != null) {
                      Map<dynamic, dynamic> data = snapshot.data.snapshot.value;

                      projectCarouselModelList.clear();

                      data.forEach((key, value) {
                        projectCarouselModelList.add(
                            new CarouselData(value['IMGURL'], value['LINK']));
                      });

                      return CarouselSlider(
                        height: 150.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 8),
                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayOnTouch: Duration(seconds: 10),
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        items: projectCarouselModelList.map((value) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.30,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.lightBlue, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints.expand(),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                          image: new NetworkImage(value.imgUrl),
                                          fit: BoxFit.fitWidth,
                                        )),
                                  )),
                            );
                          });
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Something Went Wrong!"));
                    }
                    return Center(
                      child: Text("Loading..."),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Best Selling Projects",
                    style: TextStyle(
                        fontFamily: "OpenSans-Bold",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                // Test
                FutureBuilder(
                  future: FirebaseDatabase.instance
                      .reference()
                      .child("Notespedia/PROJECTS/STREAM")
                      .once(),
                  builder: (context, AsyncSnapshot) {
                    if (AsyncSnapshot.hasData &&
                        !AsyncSnapshot.hasError &&
                        AsyncSnapshot.data.value != null) {
                      Map<dynamic, dynamic> data = AsyncSnapshot.data.value;

                      data.forEach((key, value) {
                        projectDataModelList.add(new projectDataModel(
                            value['PROJECTTITLE'],
                            value['PROJECTDESCRIPTION'],
                            value['PROJECTIMG'],
                            value['PROJECTAUTHOR'],
                            value['PROJECTCOST'],
                            value['PROJECTSTREAM']));
                      });

                      return Container(
                          height: 125,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: projectDataModelList.map((value) {
                                return Container(
                                  margin: EdgeInsets.only(left: 5),
                                  width: 200,
                                  child: Card(
                                    color: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.lightBlue, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                      child: Text(value.projectTitle),
                                    ),
                                  ),
                                );
                              }).toList()));
                    } else if (AsyncSnapshot.hasError) {
                      return Center(
                        child: Text("Something Went Wrong :("),
                      );
                    }
                    return Center(
                      child: Text("Loading..."),
                    );
                  },
                ),
                // Test

//                Container(
//                  height: 125,
//                  child: ListView(
//                    scrollDirection: Axis.horizontal,
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(left: 5),
//                        width: 200,
//                        child: Card(
//                          color: Colors.redAccent,
//                          shape: RoundedRectangleBorder(
//                              side:
//                                  BorderSide(color: Colors.lightBlue, width: 1),
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(10))),
//                          child: Center(
//                            child: Text("Hello World"),
//                          ),
//                        ),
//                      ),
//                      Container(
//                        width: 200,
//                        child: Card(
//                          color: Colors.blueAccent,
//                          shape: RoundedRectangleBorder(
//                              side:
//                                  BorderSide(color: Colors.lightBlue, width: 1),
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(10))),
//                          child: Center(
//                            child: Text("Hello World"),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        fontFamily: "OpenSans-Bold",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: 120,
                        child: Card(
                          color: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.lightBlue, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text("Hello World"),
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: Card(
                          color: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.lightBlue, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text("Hello World"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //////////////////////////////////////////
                // Recomended For Your Profile
                /////////////////////////////////////////
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Recommended for your Profile",
                    style: TextStyle(
                        fontFamily: "OpenSans-Bold",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 150,
                        margin: EdgeInsets.only(left: 5),
                        child: Card(
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.lightBlue, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text("Hello World"),
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        child: Card(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.lightBlue, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text("Hello World"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                /////////////////////////////////////////
              ],
            ),
          ),
        ),
      ),
    );
  }
}
