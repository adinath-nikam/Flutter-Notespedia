import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CarouselData {
  String imgUrl, link;

  CarouselData(this.imgUrl, this.link);

  CarouselData.fromSnapshot(DataSnapshot dataSnapshot) {
    imgUrl = dataSnapshot.value['IMGURL'];
    link = dataSnapshot.value['LINK'];
  }
}
