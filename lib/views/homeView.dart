import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notespedia/models/models.dart';
import 'package:notespedia/models/userDataModel.dart';
import 'package:notespedia/views/appBar.dart';
import 'package:notespedia/views/homeProfileCardView.dart';
import 'package:notespedia/views/ideView.dart';
import 'package:notespedia/views/libraryView.dart';
import 'package:notespedia/views/examView.dart';
import 'package:notespedia/views/projectMarketPlace.dart';
import 'package:notespedia/views/scholarshipView.dart';
import 'package:notespedia/views/jobsView.dart';

class homeView extends StatefulWidget {
  final userDataModel userdatamodel;

  homeView({this.userdatamodel});

  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView>
    with AutomaticKeepAliveClientMixin<homeView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 5,
            child: Scaffold(
              body: TabBarView(
                children: [
                  home(
                    userdatamodel: widget.userdatamodel,
                  ),
                  libraryView(),
                  scholarshipView(),
                  jobsView(),
                  projectMarketPlace(),
                ],
              ),
              bottomNavigationBar: new TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    icon: Icon(Icons.library_books),
                  ),
                  Tab(
                    icon: Icon(Icons.school),
                  ),
                  Tab(
                    icon: Icon(Icons.work),
                  ),
                  Tab(
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
                unselectedLabelColor: Colors.black38,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.lightBlue,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.lightBlue,
              ),
            )));
  }
}

// HomeScreen, CarouselSlider

class home extends StatefulWidget {
  final userDataModel userdatamodel;

  home({this.userdatamodel});

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> with AutomaticKeepAliveClientMixin<home> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100), child: appBar()),
        backgroundColor: Colors.white,
        body: homeView(widget.userdatamodel),
//        floatingActionButton: FloatingActionButton.extended(
//          onPressed: () { Navigator.push(context,
//              MaterialPageRoute(builder: (context) => test()));},
//          label: Text("Let's Code"),
//          icon: Icon(Icons.code),
//        ),
      ),
    );
  }

  homeView(userDataModel userdatamodel) {
    List<CarouselData> carouselModel = [];
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child("Notespedia/CAROUSELS/HOMECAROUSELDATA")
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  Map<dynamic, dynamic> data = snapshot.data.snapshot.value;

                  carouselModel.clear();

                  data.forEach((key, value) {
                    carouselModel.add(
                        new CarouselData(value['IMGURL'], value['DATAURL']));
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
                    items: carouselModel.map((value) {
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: new NetworkImage(value.imgUrl),
                                      fit: BoxFit.fitWidth,
                                    )),
                              )),
                        );
                      });
                    }).toList(),
                  );
                } else {
                  return Center(child: Text("Something Went Wrong!"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
