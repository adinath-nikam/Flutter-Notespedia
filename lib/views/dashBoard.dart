import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notespedia/views/homeView.dart';

class dashBoard extends StatelessWidget {
  Items item1 = new Items(
      title: "LIBRARY",
      subtitle: "March, Wednesday",
      img: "assets/images/circularProfileImage.png");

  Items item2 = new Items(
    title: "DIPLOMA QP",
    subtitle: "Bocali, Apple",
    img: "assets/food.png",
  );
  Items item3 = new Items(
    title: "DCET QP",
    subtitle: "Lucy Mao going to Office",
    img: "assets/map.png",
  );
  Items item4 = new Items(
    title: "SCHOLARSHIPS",
    subtitle: "Rose favirited your Post",
    img: "assets/festival.png",
  );
  Items item5 = new Items(
    title: "EXAM SCHEDULE",
    subtitle: "Homework, Design",
    img: "assets/todo.png",
  );
  Items item6 = new Items(
    title: "RESULTS",
    subtitle: "",
    img: "assets/setting.png",
  );
  Items item7 = new Items(
    title: "INTERNSHIPS",
    subtitle: "Selected Internsips Only for you!",
    img: "assets/setting.png",
  );
  Items item8 = new Items(
    title: "JOBS",
    subtitle: "Selected Internsips Only for you!",
    img: "assets/setting.png",
  );
  Items item9 = new Items(
    title: "BEST COLLEGES",
    subtitle: "Selected Internsips Only for you!",
    img: "assets/setting.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6, item7, item8, item9];
    Color color = Colors.lightBlue ;
    return SafeArea(
      child: Column(
        children: <Widget>[
          headerView(),
          Flexible(
            child: GridView.count(
                childAspectRatio: 1.0,
                padding: EdgeInsets.only(left: 16, right: 16),
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                children: myList.map((data) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          data.img,
                          width: 42,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.title,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          data.subtitle,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
  headerView() {
    return Container(
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Hi, Adinath N",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(
                width: 80,
              ),
              new Container(
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                      image: new AssetImage(
                          "assets/images/circularProfileImage.png"),
                      fit: BoxFit.cover),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Colors.lightBlue,
                    width: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String img;
  Items({this.title, this.subtitle, this.img});
}
