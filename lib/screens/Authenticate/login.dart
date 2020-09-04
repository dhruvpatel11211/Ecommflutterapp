import 'package:immaculateflutterecomm/screens/Authenticate/phone_login.dart';
import 'package:immaculateflutterecomm/screens/Authenticate/resetPassword.dart';
import 'package:immaculateflutterecomm/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "", error = "";
  final AuthService _auth = AuthService();
  final border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 0),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  Widget _signInButton() {
    return SizedBox(
        width: double.infinity,
          child: OutlineButton(
        onPressed: () {
          _auth.handleGoogleSignIn();
        },
        
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                'https://clipartart.com/images/www-google-com-clipart-4.jpg',
                width: 30,

              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButtonPhone() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PhoneLogin()));
        },
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        // highlightElevation: 0,
        // borderSide: BorderSide(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                'https://icons.iconarchive.com/icons/dtafalonso/android-l/512/Phone-icon.png',
                width: 18,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Sign in with Mobile',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                            "Login",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Please enter your details",
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
                                hintText: "Email",
                                filled: true,
                                border: InputBorder.none,
                                contentPadding: new EdgeInsets.all(5),
                                enabledBorder: border,
                                focusedBorder: border,
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Email is empty" : null,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
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
                                hintText: "Password",
                                filled: true,
                                border: InputBorder.none,
                                enabledBorder: border,
                                focusedBorder: border,
                              ),
                              validator: (val) => val.length < 6
                                  ? "Password must be more than 6"
                                  : null,
                              obscureText: true,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
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
                                    MaterialPageRoute(builder: (context) => ResetPassword()),
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
                                  "Login",
                                  style: TextStyle(fontSize: 18),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        error = "wrong credentials";
                                      });
                                    } else {
                                      setState(() {
                                        password = "";
                                        email = "";
                                      });
                                    }
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: double.infinity,
                              child: FlatButton(
                                onPressed: () => {widget.toggleView()},
                                child: Text(
                                  "Create an account",
                                  style: TextStyle(fontSize: 18),
                                ),
                                textColor: Colors.white,
                                padding: EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: Colors.redAccent,
                              )),
                          SizedBox(height: 20),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: double.infinity,
                                        child: GoogleSignInButton(
                                          onPressed: () {
                                            _auth.handleGoogleSignIn();
                                          },
                                         
                                        ),
                                      ),
                                      
                                    ],
                                  )),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[_signInButtonPhone()],
                          ),
                        ])))));
  }
}
