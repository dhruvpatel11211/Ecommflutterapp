import 'package:immaculateflutterecomm/screens/phone_login.dart';
import 'package:immaculateflutterecomm/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email = "",
      password = "",
      firstname = "",
      lastname = "",
      mobileno = "",
      error = "";
  final border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 0),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  Widget _signInButton() {
    return SizedBox(
      
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () {
          _auth.handleGoogleSignUp();
        },
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        // highlightElevation: 0,
        // borderSide: BorderSide(color: Colors.black),
        splashColor: Colors.redAccent,
        child: Padding(
          
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ImageIcon(
              //   ExactAssetImage('assets/googleSignIn.png')
              // ),
              Image.network(
                'https://clipartart.com/images/www-google-com-clipart-4.jpg',
                width: 30,

              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
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
        // backgroundColor: Colors.brown[100],
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //     begin: Alignment.topRight, end: Alignment.bottomLeft,
                    //     // colors: [Colors.purple[100], Colors.white]),
                    //     colors: [Colors.green[700], Colors.green[50]]),
                    ),
                padding: EdgeInsets.all(30),
                child: Form(
                    key: _formKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            "Register",
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
                              // textAlign:TextAlign.center,s
                              decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.all(5),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 20,
                                  ),
                                  hintText: "First Name",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                  filled: true,
                                  fillColor: Colors.black12,
                                  enabledBorder: border,
                                  focusedBorder: border),
                              validator: (val) =>
                                  val.isEmpty ? "First Name is empty" : null,
                              onChanged: (val) {
                                setState(() {
                                  firstname = val;
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
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 20,
                                ),
                                hintText: "Last Name",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                filled: true,
                                fillColor: Colors.black12,
                                enabledBorder: border,
                                focusedBorder: border,
                                border: InputBorder.none,
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Last name is empty" : null,
                              onChanged: (val) {
                                setState(() {
                                  lastname = val;
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
                                prefixIcon: Icon(Icons.phone, size: 20),
                                hintText: "Mobile Number",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                filled: true,
                                fillColor: Colors.black12,
                                enabledBorder: border,
                                focusedBorder: border,
                                border: InputBorder.none,
                              ),
                              validator: (val) =>
                                  val.length != 10 ? "Must be 10 digits" : null,
                              onChanged: (val) {
                                setState(() {
                                  mobileno = val;
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
                                  prefixIcon: Icon(Icons.email, size: 20),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                  filled: true,
                                  fillColor: Colors.black12,
                                  enabledBorder: border,
                                  focusedBorder: border,
                                  border: InputBorder.none),
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
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                filled: true,
                                fillColor: Colors.black12,
                                enabledBorder: border,
                                focusedBorder: border,
                                border: InputBorder.none,
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
                          SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            child: FlatButton(
                              child: Text(
                                "Register",
                                style: TextStyle(fontSize: 18),
                              ),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: Colors.redAccent,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email,
                                          password,
                                          firstname,
                                          lastname,
                                          mobileno);
                                  if (result == null) {
                                    setState(() {
                                      error = "wrong credentials";
                                    });
                                  } else {
                                    setState(() {
                                      firstname = "";
                                      lastname = "";
                                      mobileno = "";
                                      password = "";
                                      email = "";
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              child: FlatButton(
                                onPressed: () => {widget.toggleView()},
                                child: Text(
                                  "Already Have An Account?",
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 12),
                                ),
                              )),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // children: <Widget>[_signInButton()],
                            children: <Widget>[
                              SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: double.infinity,
                                        child: GoogleSignInButton(
                                          onPressed: () {
                                            _auth.handleGoogleSignUp();
                                          },
                                         
                                        ),
                                      ),
                                      
                                    ],
                                  )),
                            ],
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[_signInButtonPhone()],
                          ),
                        ])))));
  }
}
