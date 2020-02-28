import 'package:firebase_auth/firebase_auth.dart';

class User{

  final String uid;
  final String email;
  final bool isEmailVerified;

  User({this.uid,this.email,this.isEmailVerified});


  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory User.fromFireStore(FirebaseUser firebaseUser){
      return User(
      uid: firebaseUser.uid ?? '',
      email: firebaseUser.email ?? '',
      isEmailVerified: firebaseUser.isEmailVerified ?? false,
    );



  }





}