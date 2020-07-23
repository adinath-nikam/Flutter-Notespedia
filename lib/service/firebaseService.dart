import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class firebaseService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> getFirebaseUserId() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    final firebaseUserId = user.uid;
    return firebaseUserId;
  }

  Future<String> getUserPhoneNumber() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    final firebaseUserPhoneNumber = user.phoneNumber;
    return firebaseUserPhoneNumber;
  }

  Future<FirebaseUser> getFirebaseUser() async {
    final FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    return firebaseUser;
  }
}