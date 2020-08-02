import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notespedia/models/models.dart';
import 'package:notespedia/views/appBar.dart';

class scholarshipView extends StatefulWidget {
  @override
  _scholarshipViewState createState() => _scholarshipViewState();
}

class _scholarshipViewState extends State<scholarshipView>
    with AutomaticKeepAliveClientMixin<scholarshipView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(preferredSize: const Size.fromHeight(100), child: appBar(),),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Scholarships, that Matters",
                  style: TextStyle(
                    fontFamily: "OpenSans-Bold",
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  "Selected scholarship programmes only for Diploma Students.",
                  style: TextStyle(
                      fontFamily: "OpenSans-Regular",
                      fontSize: 12.0,
                      color: Colors.grey[800]),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: FutureBuilder(
                    future: FirebaseDatabase.instance
                        .reference()
                        .child("Notespedia/SCHOLARSHIPS")
                        .once(),
                    builder: (context, AsyncSnapshot) {
                      if (AsyncSnapshot.hasData &&
                          !AsyncSnapshot.hasError &&
                          AsyncSnapshot.data.value != null) {
                        List<scholarshipModel> scModelList = [];

                        Map<dynamic, dynamic> data = AsyncSnapshot.data.value;
                        scModelList.clear();

                        data.forEach((key, value) {
                          scModelList.add(
                            new scholarshipModel(
                                scName: value['SCNAME'],
                                scEligibility: value['SCELIGIBILITY'],
                                scAward: value['SCAWARD'],
                                scImgUrl: value['SCIMGURL'],
                                scLastDate: value['SCLASTDATE'],
                                scUrl: value['SCURL']),
                          );
                        });

                        return ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          children: scModelList.map((value) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.lightBlue,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Image(
                                        image: NetworkImage(value.scImgUrl),
                                        fit: BoxFit.cover,
                                      ),
                                      Divider(
                                        height: 20,
                                        thickness: 1,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.school,
                                            color: Colors.lightBlue,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              value.scName,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "OpenSans-Bold",
                                              ),
                                              overflow: TextOverflow.visible,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            color: Colors.lightBlue,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              value.scLastDate,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontFamily: "OpenSans-Regular",
                                                  color: Colors.grey[600]),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.gavel,
                                            color: Colors.lightBlue,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            value.scEligibility,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontFamily: "OpenSans-Regular",
                                                color: Colors.grey[600]),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.account_balance_wallet,
                                            color: Colors.lightBlue,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            value.scAward,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontFamily: "OpenSans-Regular",
                                                color: Colors.grey[600]),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: RaisedButton(
                                          child: Text("Apply"),
                                          textColor: Colors.white,
                                          onPressed: () {},
                                          color: Colors.lightBlue,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: Text("Loading..."),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
