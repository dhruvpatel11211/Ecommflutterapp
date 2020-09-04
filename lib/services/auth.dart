import 'package:immaculateflutterecomm/screens/Home/homeScreen.dart';
import 'package:immaculateflutterecomm/models/user.dart';
import 'package:immaculateflutterecomm/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _codeController = TextEditingController();

  User _userfromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userfromFirebaseUser(user));
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      DatabaseService(uid: user.uid);

      print(user.email);
      print("IS the name and signed in");
      return _userfromFirebaseUser(user);
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<User> handleGoogleSignUp() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print(user.displayName);
    print(user.phoneNumber);
    
    final names = user.displayName.split(' ');
    final firstName = names[0];
    final lastName = names.length > 1 ? names[1] : '';

    await DatabaseService(uid: user.uid).putUserData(user.email, firstName, lastName, "");
    return _userfromFirebaseUser(user);
    // return 'signInWithGoogle succeeded: $user';
  }

  Future<User> handleGoogleSignIn() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser user = result.user;
    print(user.displayName);
    print(user.phoneNumber);

    DatabaseService(uid: user.uid);
    // await DatabaseService.putUserData(user.email, firstName, lastName, "");
    return _userfromFirebaseUser(user);
    // return 'signInWithGoogle succeeded: $user';
  }

  Future registerWithEmailAndPassword(String email, String password,
      String firstname, String lastname, String mobileno) async {
    try {
      print("After TRy");
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).putUserData(email, firstname, lastname, mobileno);;
      
      print(user);
      print("IS the name");

      return _userfromFirebaseUser(user);
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future phoneLogin(String phone, BuildContext context) async {
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();
          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;
          if (user != null) {
            print("Sign in using Phone");
            await DatabaseService(uid: user.uid).putUserData("", "", "", phone);
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      )
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      color: Colors.blue,
                      onPressed: () async {
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId,
                                smsCode: _codeController.text.trim());
                        AuthResult result =
                            await _auth.signInWithCredential(credential);
                        FirebaseUser user = result.user;
                        if (user != null) {
                          DatabaseService(uid: user.uid);
                        } else {
                          print("ERROR");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }
}
