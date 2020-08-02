import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:notespedia/models/bookDataModel.dart';
import 'package:notespedia/models/carouselModel.dart';
import 'package:notespedia/views/pdfViewer.dart';

import 'appBar.dart';

class libraryView extends StatefulWidget {
  @override
  _libraryViewState createState() => _libraryViewState();
}

class _libraryViewState extends State<libraryView>
    with AutomaticKeepAliveClientMixin<libraryView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(100), child: appBar(),),
        body: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TabBar(
                    unselectedLabelColor: Colors.blueAccent,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blueAccent),
                    tabs: [
                      Tab(
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.blueAccent, width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Theory",
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.blueAccent, width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Lab"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.blueAccent, width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("QPs"),
                          ),
                        ),
                      ),
                    ]),
              ),
              Expanded(
                flex: 1,
                child: TabBarView(
                  children: [
                    bookFutureBuilder(
                        "Theory",
                        "Note: Notespedia Does'nt own any of this product, these are protected under copyright infringement.",
                        "Notespedia/BOOKS/STREAM/SEMESTER/THEORY"),
                    bookFutureBuilder(
                        "Laboratory",
                        "Note: Notespedia Does'nt own any of this product, these are protected under copyright infringement.",
                        "Notespedia/BOOKS/STREAM/SEMESTER/THEORY"),
                    bookFutureBuilder(
                        "Question Papers",
                        "Note: Notespedia Does'nt own any of this product, these are protected under copyright infringement.",
                        "Notespedia/BOOKS/STREAM/SEMESTER/THEORY"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bookFutureBuilder(String heading, String body, String dbPath) {
    List<bookDataModel> bookDataModelList = [];
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              heading,
              style: TextStyle(
                fontSize: 18,
                fontFamily: "OpenSans-Bold",
              ),
            ),
            Text(
              body,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "OpenSans-Regular",
                  color: Colors.grey[800]),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future:
                  FirebaseDatabase.instance.reference().child(dbPath).once(),
              builder: (context, AsyncSnapshot) {
                print(AsyncSnapshot.data);
                if (AsyncSnapshot.hasData &&
                    !AsyncSnapshot.hasError &&
                    AsyncSnapshot.data.value != null) {
                  Map<dynamic, dynamic> data = AsyncSnapshot.data.value;
                  bookDataModelList.clear();
                  data.forEach((key, value) {
                    bookDataModelList.add(new bookDataModel(
                        value['BOOKNAME'],
                        value['BOOKAUTHOR'],
                        value['BOOKRATING'],
                        value['BOOKIMGURL'],
                        value['BOOKURL']));
                  });

                  return ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    children: bookDataModelList.map((value) {
                      // -------
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => pdfViewer(
                                      url: value.bookUrl,
                                    )),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.lightBlue, width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: Image(
                                          image: NetworkImage(value.bookImgUrl),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    value.bookName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "OpenSans-Bold"),
                                    overflow: TextOverflow.visible,
                                  ),
                                  Text(
                                    value.bookAuthor,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "OpenSans-Regular"),
                                    overflow: TextOverflow.visible,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RatingBarIndicator(
                                    rating: value.bookRating,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.lightBlue,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                      // -------
                    }).toList(),
                  );
                } else {
                  return Center(
                    child: Text("Loding..."),
                  );
                }
              },
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
