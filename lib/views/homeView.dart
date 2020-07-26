import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notespedia/models/carouselModel.dart';
import 'package:notespedia/models/userDataModel.dart';
import 'package:notespedia/service/firebaseService.dart';
import 'package:notespedia/views/appBar.dart';
import 'package:notespedia/views/background_1.dart';
import 'package:notespedia/views/homeProfileCardView.dart';
import 'package:notespedia/views/profileBuild.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:notespedia/views/libraryView.dart';
import 'dashBoard.dart';
import 'splash_view.dart';
import 'package:notespedia/views/examView.dart';
import 'package:notespedia/views/scholarshipView.dart';
import 'package:notespedia/views/jobsView.dart';
import 'package:notespedia/views/examView.dart';

class homeView extends StatefulWidget {
  final userDataModel userdatamodel;

  homeView({this.userdatamodel});

  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.book),
        title: ("Library"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.card_membership),
        title: ("Scholarships"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.work),
        title: ("Jobs"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.lab_flask_solid),
        title: ("Exam"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      home(userdatamodel: widget.userdatamodel),
      libraryView(),
      scholarshipView(),
      jobsView(),
      dashBoard()
    ];
  }

  @override
  void initState() {
//    FirebaseDatabase.instance
//        .reference()
//        .child("Notespedia/USERS/+919113910407")
//        .once()
//        .then((value) {
//      userdatamodel = new userDataModel.fromSnapshot(value);
//      print(userdatamodel.getUserName);
//    });

    print(widget.userdatamodel.getUserName);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      bottomScreenMargin: 50,
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears.
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style13, // Choose the nav bar style with this property.
    );
  }
}

// HomeScreen, CarouselSlider

class home extends StatefulWidget {
  final userDataModel userdatamodel;

  home({this.userdatamodel});

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: homeView(widget.userdatamodel),
      ),
    );
  }

  homeView(userDataModel userdatamodel) {
    List<CarouselData> carouselModel = [];
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          appBar(),
          StreamBuilder(
            stream: FirebaseDatabase.instance
                .reference()
                .child("Notespedia/CarouselData")
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data.snapshot.value != null) {
                Map<dynamic, dynamic> data = snapshot.data.snapshot.value;

                data.forEach((key, value) {
                  carouselModel
                      .add(new CarouselData(value['IMGURL'], value['LINK']));
                });

                return CarouselSlider(
                  height: 180.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 8),
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  items: carouselModel.map((value) {
                    print(value.link);
                    return Builder(builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.lightBlue, width: 2),
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
                return Text("No!");
              }
            },
          ),
          homeProfileCardView(
            userdatamodel: userdatamodel,
          ),
        ],
      ),
    );
  }
}
