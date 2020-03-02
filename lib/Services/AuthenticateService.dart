import 'package:firebase_auth/firebase_auth.dart';
import 'package:iwas_port/Models/user.dart';
import 'package:iwas_port/Services/AuthException.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService();

  // Auth Change User Stream
  Stream<User> get user {
    try {
      return _auth.onAuthStateChanged
          .map((FirebaseUser firebaseUser) => User.fromFireStore(firebaseUser));
    } catch (AuthError) {
      throw AuthenException(AuthError.message);
    }
  }

  // SignIn with Email & Password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult signInResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser fUser = signInResult.user;
      return User.fromFireStore(fUser);
    } catch (SignInError) {
      throw AuthenException(SignInError.message);
    }
  }

  // Register with Email & Password
  Future<User> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult registerResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser fUser = registerResult.user;
      return User.fromFireStore(fUser);
    } catch (RegisterError) {
      throw AuthenException(RegisterError.message);
    }
  }

  Future sendPasswordResetMail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (passwordResetError) {
      throw AuthenException(passwordResetError.message);
    }
  }

  // SignOut
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (signOutError) {
      throw AuthenException(signOutError.message);
    }
  }
}
