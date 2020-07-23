import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:notespedia/service/firebaseService.dart';
import 'package:notespedia/views/profileBuild.dart';

import 'splash_view.dart';


class homeView extends StatefulWidget {
  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  String _mySelection;

  List<streamsModelClass> streamsList = [];

  var selectedStream;

  @override
  void initState() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Notespedia/DropdownData/Streams");
    databaseReference.once().then((DataSnapshot dataSnapshot) {



      Map data = dataSnapshot.value;

      data.forEach((index, data) {
        streamsModelClass streamModel = new streamsModelClass(data);
        streamsList.add(streamModel);
      });

      print("Data>>>>> $data");


      setState(() {
        print("Length: ${streamsList.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Logout"),
                    onPressed: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (BuildContext context) => SplashScreen()
                          )
                      );
                    },
                  ),

                  StreamBuilder(
                    stream: FirebaseDatabase.instance.reference().child("Notespedia/DropdownData/Streams").onValue,
                    builder: (context, snap) {
                      if (snap.hasData &&
                          !snap.hasError &&
                          snap.data.snapshot.value != null) {
                        Map data = snap.data.snapshot.value;
                        print("Hello,: $data");
                        List item = [];

                        data.forEach(
                                (index, data) => item.add(data));

                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(item[index]),
                              );
                            },
                          ),
                        );
                      } else
                        return Center(child: Text("No data"));
                    },
                  ),

                  /////

                  Container(
                    child: streamsList.length ==0 ? Text('No Data. Av') :
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: "select your stream",
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
                      onChanged: (streamsModelClass Value) {
                        setState(() {
                          selectedStream = Value;
                        });
                      },
                      items: streamsList.map((streamsModelClass user) {
                        return DropdownMenuItem<streamsModelClass>(
                          value: user,
                          child: Row(
                            children: <Widget>[
                              Text(
                                user.name,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  )

                  ////



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class streamsModelClass {
  final String name;
  const streamsModelClass(this.name);
}