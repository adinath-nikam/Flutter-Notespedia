import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:notespedia/models/models.dart';
import 'package:notespedia/models/userDataModel.dart';
import 'package:notespedia/service/firebaseService.dart';
import 'package:notespedia/views/splash_view.dart';
import 'package:tuple/tuple.dart';
import 'authTosWidget.dart';
import 'background_1.dart';
import 'homeView.dart';

final userNameTextEditController = TextEditingController();
final userEmailTextEditController = TextEditingController();
final _profileFormKey = GlobalKey<FormState>();
String fUid, fPhNumber;
var selectedStream, selectedSemester, selectedInstitute, selectedGender;

class profileBuild extends StatefulWidget {
  @override
  _profileBuildState createState() => _profileBuildState();
}

class _profileBuildState extends State<profileBuild> {
  bool _loading;
  FToast fToast;

  @override
  void initState() {
    super.initState();
    _loading = false;
    fToast = FToast(context);
  }

  progressBarState(bool state) {
    setState(() {
      _loading = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    String getUid(String uid) {
      fUid = uid;
    }

    String getPhoneNumber(String phNumber) {
      fPhNumber = phNumber;
    }

    firebaseService().getFirebaseUserId().then((value) {
      getUid(value);
    });
    firebaseService().getUserPhoneNumber().then((value) {
      getPhoneNumber(value);
    });

    return Scaffold(
      body: profileBuildBody(),
    );
  }

  profileBuildBody() {
    return Center(
      child: Stack(
        children: <Widget>[background(""), profileBuildCard()],
      ),
    );
  }

  profileBuildCard() {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Card(
                elevation: 20.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/images/logo.png"),
                        height: 150,
                        width: 150,
                      ),
                      Text(
                        "Let's Build your Profile!,.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "font_primary",
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      profileForm(),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: RaisedButton(
                            color: Colors.lightBlue,
                            onPressed: () {
                              if (_profileFormKey.currentState.validate()) {
                                if (selectedStream == null) {
                                  print("No Stream Data");
                                } else {
                                  progressBarState(true);
                                  userDataModel userdatamodel =
                                      new userDataModel(
                                          fUid,
                                          userNameTextEditController.text
                                              .toString(),
                                          userEmailTextEditController.text
                                              .toString(),
                                          selectedStream,
                                          selectedSemester,
                                          fPhNumber,
                                          selectedInstitute,
                                          selectedGender,
                                          new DateFormat()
                                              .format(DateTime.now()));

                                  FirebaseDatabase.instance
                                      .reference()
                                      .child("Notespedia/USERS/" + fPhNumber)
                                      .set(userdatamodel.toJson())
                                      .whenComplete(() {
                                    fToast.showToast(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 12.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          color: Colors.greenAccent,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.check),
                                            SizedBox(
                                              width: 12.0,
                                            ),
                                            Text(
                                                "Profile Created Successfully!"),
                                          ],
                                        ),
                                      ),
                                      gravity: ToastGravity.BOTTOM,
                                      toastDuration: Duration(seconds: 2),
                                    );
                                    print('UPLOAD SUCCESSFUL');
                                    progressBarState(false);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SplashScreen()));
                                  });
                                }
                              }
                            },
                            child: Text(
                              "Create Profile",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "font_primary"),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _loading
                          ? LinearProgressIndicator()
                          : SizedBox(
                              height: 1,
                            ),
                      Divider(
                        color: Colors.lightBlue,
                        height: 20,
                      ),
                      authTosWidget(),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

//Profile Form
class profileForm extends StatefulWidget {
  @override
  _profileFormState createState() => _profileFormState();
}

class _profileFormState extends State<profileForm> {
  @override
  void initState() {
    selectedStream = null;
    selectedSemester = null;
    selectedGender = null;
    selectedInstitute = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _profileFormKey,
        child: Column(
          children: <Widget>[
//            Username
            TextFormField(
              controller: userNameTextEditController,
              // ignore: missing_return
              validator: (String value) {
                if (value.isEmpty) {
                  return "Required!";
                }
              },
              maxLength: 21,
              maxLines: 1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Username",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.lightBlue,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 2, color: Colors.lightBlue),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
//            Email
            TextFormField(
              // ignore: missing_return
              validator: (String value) {
                if (value.isEmpty) {
                  return "Required!";
                }
              },
              controller: userEmailTextEditController,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "username@example.com",
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Colors.lightBlue,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 2, color: Colors.lightBlue),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            streamsDropDown(
                "Notespedia/DROPDOWNS/STREAMS",
                "Select your Stream",
                Icon(
                  Icons.school,
                  color: Colors.lightBlue,
                )),

            SizedBox(
              height: 20,
            ),

            semestersDropDown(
                "Notespedia/DROPDOWNS/SEMESTERS",
                "Select your Semester",
                Icon(
                  Icons.date_range,
                  color: Colors.lightBlue,
                )),

            SizedBox(
              height: 20,
            ),

            institutesDropDown(
                "Notespedia/DROPDOWNS/INSTITUTES",
                "Select your Institute",
                Icon(
                  Icons.location_city,
                  color: Colors.lightBlue,
                )),

            SizedBox(
              height: 20,
            ),

            genderDropDown(
                "Notespedia/DROPDOWNS/GENDERS",
                "Select your Gender",
                Icon(
                  Icons.call_split,
                  color: Colors.lightBlue,
                )),

            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  //Streams DropDown --------------
  streamsDropDown(String dbPath, String hint, Icon dropdownIcon) {
    return FutureBuilder(
      future: FirebaseDatabase.instance.reference().child(dbPath).once(),
      builder: (context, AsyncSnapshot) {
        if (AsyncSnapshot.hasData && AsyncSnapshot.data.value != null) {
          List<dropDownDataClass> dropDownDataClassList = [];

          Map<dynamic, dynamic> data = AsyncSnapshot.data.value;

          data.forEach((key, value) {
            dropDownDataClassList.add(new dropDownDataClass(value));
          });

          return Container(
              child: dropDownDataClassList.length == 0
                  ? Text('No Data. Av')
                  : DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: hint,
                        prefixIcon: dropdownIcon,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 2, color: Colors.lightBlue),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedStream = value;
                        });
                      },
                      items: dropDownDataClassList.map((item) {
                        return DropdownMenuItem(
                          value: item.dropDownItem,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 180,
                                child: Text(
                                  item.dropDownItem,
                                  style: TextStyle(color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ));
        } else if (AsyncSnapshot.hasError) {
          return Text("Something Went Wrong");
        }
        return Center(child: Text("Loading..."));
      },
    );
  }
//Streams DropDown -------------

//Semesters DropDown --------------
  semestersDropDown(String dbPath, String hint, Icon dropdownIcon) {
    return FutureBuilder(
      future: FirebaseDatabase.instance.reference().child(dbPath).orderByKey().once(),
      builder: (context, AsyncSnapshot) {
        if (AsyncSnapshot.hasData && AsyncSnapshot.data.value != null) {
          List<dropDownDataClass> dropDownDataClassList = [];

          Map<dynamic, dynamic> data = AsyncSnapshot.data.value;

          data.forEach((key, value) {
            dropDownDataClassList.add(new dropDownDataClass(value));
          });

          return Container(
              child: dropDownDataClassList.length == 0
                  ? Text('No Data. Av')
                  : DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: hint,
                  prefixIcon: dropdownIcon,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide:
                    BorderSide(width: 2, color: Colors.lightBlue),
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedSemester = value;
                  });
                },
                items: dropDownDataClassList.map((item) {
                  return DropdownMenuItem(
                    value: item.dropDownItem,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 180,
                          child: Text(
                            item.dropDownItem,
                            style: TextStyle(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ));
        } else if (AsyncSnapshot.hasError) {
          return Text("Something Went Wrong");
        }
        return Center(child: Text("Loading..."));
      },
    );
  }
//Semesters DropDown -------------

//Institutes DropDown --------------
  institutesDropDown(String dbPath, String hint, Icon dropdownIcon) {
    return FutureBuilder(
      future: FirebaseDatabase.instance.reference().child(dbPath).once(),
      builder: (context, AsyncSnapshot) {
        if (AsyncSnapshot.hasData && AsyncSnapshot.data.value != null) {
          List<dropDownDataClass> dropDownDataClassList = [];

          Map<dynamic, dynamic> data = AsyncSnapshot.data.value;

          data.forEach((key, value) {
            dropDownDataClassList.add(new dropDownDataClass(value));
          });

          return Container(
              child: dropDownDataClassList.length == 0
                  ? Text('No Data. Av')
                  : DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: hint,
                  prefixIcon: dropdownIcon,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide:
                    BorderSide(width: 2, color: Colors.lightBlue),
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedInstitute = value;
                  });
                },
                items: dropDownDataClassList.map((item) {
                  return DropdownMenuItem(
                    value: item.dropDownItem,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 180,
                          child: Text(
                            item.dropDownItem,
                            style: TextStyle(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ));
        } else if (AsyncSnapshot.hasError) {
          return Text("Something Went Wrong");
        }
        return Center(child: Text("Loading..."));
      },
    );
  }
//Institutes DropDown -------------


//Gender DropDown --------------
  genderDropDown(String dbPath, String hint, Icon dropdownIcon) {
    return FutureBuilder(
      future: FirebaseDatabase.instance.reference().child(dbPath).once(),
      builder: (context, AsyncSnapshot) {
        if (AsyncSnapshot.hasData && AsyncSnapshot.data.value != null) {
          List<dropDownDataClass> dropDownDataClassList = [];

          Map<dynamic, dynamic> data = AsyncSnapshot.data.value;

          data.forEach((key, value) {
            dropDownDataClassList.add(new dropDownDataClass(value));
          });

          return Container(
              child: dropDownDataClassList.length == 0
                  ? Text('No Data. Av')
                  : DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: hint,
                  prefixIcon: dropdownIcon,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide:
                    BorderSide(width: 2, color: Colors.lightBlue),
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                items: dropDownDataClassList.map((item) {
                  return DropdownMenuItem(
                    value: item.dropDownItem,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 180,
                          child: Text(
                            item.dropDownItem,
                            style: TextStyle(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ));
        } else if (AsyncSnapshot.hasError) {
          return Text("Something Went Wrong");
        }
        return Center(child: Text("Loading..."));
      },
    );
  }
//Gender DropDown -------------
}
