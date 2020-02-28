import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_stream/firebase_user_stream.dart';
import 'package:iwas_port/Models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService();

  // Auth Change User Stream
  Stream<User> get user {
    try {
      return _auth.onAuthStateChanged
          .map((FirebaseUser firebaseUser) => User.fromFireStore(firebaseUser));
    } catch (AuthError) {
      throw AuthException(AuthError.code, AuthError.message);
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
      throw AuthException(SignInError.code, SignInError.message);
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
      throw AuthException(RegisterError.code, RegisterError.message);
    }
  }

  Future sendPasswordResetMail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (passwordResetError) {
      throw AuthException(passwordResetError.code, passwordResetError.message);
    }
  }

  // SignOut
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (signOutError) {
      throw AuthException(signOutError.code, signOutError.message);
    }
  }
}
