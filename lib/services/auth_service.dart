import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_firebase/pages/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try {
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          storeUserData(userCredential);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (builder) => const HomePage()),
              (route) => false);
        } catch (e) {
          showSnackBar(context, e.toString());
        }
      } else {
        showSnackBar(context, 'Not able to sign in');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  /// For storing the [uid]&[userCredential] to the flutter_secure_storage
  Future<void> storeUserData(UserCredential userCredential) async {
    await storage.write(key: 'uid', value: userCredential.user!.uid.toString());
    await storage.write(
        key: 'usercredential', value: userCredential.toString());
  }

  /// It will return the [uid] from flutter_secure_storage
  Future<String?> getUid() async {
    final uid = await storage.read(key: 'uid');
    return uid;
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      await storage.delete(key: 'uid');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted;
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout;
    PhoneVerificationFailed verificationFailed;
    PhoneCodeSent codeSent;

    verificationCompleted = (PhoneAuthCredential phoneAuthCredential) async =>
        showSnackBar(context, 'Verification Completed');

    verificationFailed = (FirebaseAuthException exception) =>
        showSnackBar(context, exception.toString());

    codeSent = (String verificationId, [int? forceResendingToken]) {
      showSnackBar(context, 'Verification code sent');
      setData(verificationId);
    };

    codeAutoRetrievalTimeout =
        (String verificationId) => showSnackBar(context, 'Time Out');

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInWithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      storeUserData(userCredential);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (builder) => const HomePage()),
          (route) => false);
      showSnackBar(context, 'Logged In');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
