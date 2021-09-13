import 'package:chat_firebase/Auth/helpers/firestore_helper.dart';
import 'package:chat_firebase/services/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   String  getUserId(){
    return FirebaseAuth.instance.currentUser.uid;
  }

  Future<UserCredential> signup(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialog.customDialog
            .showCustomDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomDialog.customDialog
            .showCustomDialog('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> signin(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);


      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.customDialog
            .showCustomDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialog.customDialog
            .showCustomDialog('Wrong password provided for that user.');
      }
    }
  }

  resetPassword(String email) async {
    CustomDialog.customDialog.showCustomDialog(
        'We have send email for reset password , please check your email');

    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  verifyEmail() async {
    await firebaseAuth.currentUser.sendEmailVerification();
    CustomDialog.customDialog.showCustomDialog(
        'verification email has been sent, please check your email');
  }

  bool checkEmailVertication() {
    return firebaseAuth.currentUser.emailVerified ?? false;
  }

  logout() async {
    firebaseAuth.signOut();
  }

  bool checkUserLogin() {
    if (firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}

