import 'package:firebase_database/firebase_database.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notespedia/models/models.dart';
import 'package:notespedia/views/appBar.dart';

class jobsView extends StatefulWidget {
  @override
  _jobsViewState createState() => _jobsViewState();
}

class _jobsViewState extends State<jobsView>
    with AutomaticKeepAliveClientMixin<jobsView> {
  @override
  bool get wantKeepAlive => true;

  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: appBar(),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SearchBar<Post>(
            hintText: "Where are you looking for ?",
            iconActiveColor: Colors.lightBlue,
            onSearch: search,
            onItemFound: (Post post, int index) {
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.description),
              );
            },
            placeHolder: SingleChildScrollView(child: futureBuilder("Notespedia/INTERNSHIPS"),)),
      ),
    ));
  }

  futureBuilder(String dbPath) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Recently Published",
            style: TextStyle(
              fontFamily: "OpenSans-Bold",
              fontSize: 16.0,
            ),
          ),
          FutureBuilder(
            future: FirebaseDatabase.instance
                .reference()
                .child("Notespedia/INTERNSHIPS")
                .once(),
            builder: (context, AsyncSnapshot) {
              if (AsyncSnapshot.hasData &&
                  !AsyncSnapshot.hasError &&
                  AsyncSnapshot.data.value != null) {
                List<internshipModel> internshipModelList = [];
                Map<dynamic, dynamic> data = AsyncSnapshot.data.value;
                internshipModelList.clear();
                data.forEach((key, value) {
                  internshipModelList.add(new internshipModel(
                      internshipName: value['INTERNNAME'],
                      internshipAward: value['INTERNAWARD'],
                      internshipCompanyName: value['INTERNCOMPANYNAME'],
                      internshipImgUrl: value['INTERNIMGURL'],
                      internshipLastDate: value['INTERNLASTDATE'],
                      internshipPlace: value['INTERNPLACE'],
                      internshipUrl: value['INTERNURL'],
                      intershipDuration: value['INTERNDURATION']));
                });
                return ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    children: internshipModelList.map((value) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.lightBlue),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Image(
                                        image: NetworkImage(
                                            value.internshipImgUrl),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            value.internshipName,
                                            style: TextStyle(
                                              fontFamily: "OpenSans-Bold",
                                              fontSize: 18.0,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.business,
                                            size: 20,
                                            color: Colors.grey[600],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            value.internshipCompanyName,
                                            style: TextStyle(
                                              fontFamily: "OpenSans-Bold",
                                              fontSize: 12.0,
                                              color: Colors.grey[600],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 15,
                                            color: Colors.grey[600],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            value.internshipPlace,
                                            style: TextStyle(
                                              fontFamily: "OpenSans-Regular",
                                              fontSize: 10.0,
                                              color: Colors.grey[600],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.account_balance_wallet,
                                                  size: 15,
                                                  color: Colors.grey[600],
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  value.internshipAward,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "OpenSans-Regular",
                                                    fontSize: 10.0,
                                                    color: Colors.grey[600],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.date_range,
                                                  size: 15,
                                                  color: Colors.grey[600],
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  value.intershipDuration,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "OpenSans-Regular",
                                                    fontSize: 10.0,
                                                    color: Colors.grey[600],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.timer,
                                              size: 15,
                                              color: Colors.grey[600],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              value.internshipLastDate,
                                              style: TextStyle(
                                                fontFamily: "OpenSans-Regular",
                                                fontSize: 10.0,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "More Details >",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: "OpenSans-Bold",
                                                  fontSize: 10.0,
                                                  color: Colors.lightBlue[500],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList());
              } else {
                return Center(
                  child: Text("Loading..."),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}
