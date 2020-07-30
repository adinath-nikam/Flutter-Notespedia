import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class bookDataModel{
  String bookName, bookAuthor, bookImgUrl, bookUrl;
  double bookRating;

  bookDataModel(this.bookName, this.bookAuthor, this.bookRating,
      this.bookImgUrl, this.bookUrl);


  bookDataModel.fromSnapshot(DataSnapshot dataSnapshot){
    bookName = dataSnapshot.value['BOOKNAME'];
    bookAuthor = dataSnapshot.value['BOOKAUTHOR'];
    bookAuthor = dataSnapshot.value['BOOKRATING'];
    bookImgUrl = dataSnapshot.value['BOOKIMGURL'];
    bookUrl = dataSnapshot.value['BOOKURL'];
  }

}