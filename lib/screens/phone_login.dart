import 'package:flutter/material.dart';
import 'package:immaculateflutterecomm/services/auth.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _phoneController = TextEditingController();
  final AuthService _auth = AuthService();
  // final _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: (MediaQuery.of(context).size.height),
      decoration: BoxDecoration(),
      padding: EdgeInsets.all(32),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Text(
              "Login",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
            )),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey[200])),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey[300])),
                  filled: true,
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Phone Number"),
              controller: _phoneController,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              child: FlatButton(
                child: Text(
                  "Start",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.white,
                padding: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.redAccent,
                onPressed: () {
                  _auth.phoneLogin(_phoneController.text.trim(), context);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
