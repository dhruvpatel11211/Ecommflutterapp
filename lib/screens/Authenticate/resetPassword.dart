import 'package:immaculateflutterecomm/services/auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailController = TextEditingController();
  final AuthService _auth = AuthService();
  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Verify your email'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Please check your email'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
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
              "Reset Password",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
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
                  hintText: "Email"),
              controller: _emailController,
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
                  "Submit",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.white,
                padding: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.redAccent,
                onPressed: () {
                  _auth.resetPassword(_emailController.text.trim());
                  _showMyDialog();
                   
                },
              ),
            ),
          ],
        ),
      ),
    ));

  }
}