import 'package:immaculateflutterecomm/screens/Authenticate/phone_login.dart';
import 'package:immaculateflutterecomm/screens/Authenticate/resetPassword.dart';
import 'package:immaculateflutterecomm/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class changePass extends StatefulWidget {
  final Function toggleView;
  changePass({this.toggleView});
  @override
  _changePassState createState() => _changePassState();
}

class _changePassState extends State<changePass> {
  final _formKey = GlobalKey<FormState>();
  String currentpassword = "",
      newpassword = "",
      confirmnewpassword = "";

  final AuthService _auth = AuthService();
  void _changePassword(String password) async{
    //Create an instance of the current user.
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_){
      print("Succesfull changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  final border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 0),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: (MediaQuery.of(context).size.height),
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.topRight,
              //     end: Alignment.bottomLeft,
              //     colors: [Colors.purple[100], Colors.white]),
              ),
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                Text(
                  "Change password",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Please enter the details",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, size: 20),
                      hintText: "Enter current Password",
                      filled: true,
                      border: InputBorder.none,
                      contentPadding: new EdgeInsets.all(5),
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                    validator: (val) =>
                        val.isEmpty ? "Password is empty" : null,
                    onChanged: (val) {
                      setState(() {
                        currentpassword = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.all(5),
                      prefixIcon: Icon(Icons.lock, size: 20),
                      hintText: "New Password",
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                    validator: (val) =>
                        val.length < 6 ? "Password must be more than 6" : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        newpassword = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.all(5),
                      prefixIcon: Icon(Icons.lock, size: 20),
                      hintText: "Confirm New Password",
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                    validator: (val) => val == newpassword
                        ? "Should be same as the new password"
                        : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        confirmnewpassword = val;
                      });
                    },
                  ),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword()),
                        )
                      },
                      child: Text(
                        "Forgot Password?",
                      ),
                    )),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    textColor: Colors.white,
                    padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.redAccent,
                    child: Text(
                      "Change password",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      if(_formKey.currentState.validate())
                        {
                          _changePassword(confirmnewpassword);
                        }
                      else
                        {
                          setState(() {
                            currentpassword='';
                            newpassword='';
                            confirmnewpassword='';
                          });
                        }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
