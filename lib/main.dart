import 'dart:async';

import 'package:immaculateflutterecomm/models/customer.dart';
import 'package:immaculateflutterecomm/screens/Wrapper.dart';
import 'package:immaculateflutterecomm/screens/Authenticate/login.dart';
import 'package:immaculateflutterecomm/screens/Authenticate/phone_login.dart';
import 'package:immaculateflutterecomm/screens/Authenticate/register.dart';
import 'package:immaculateflutterecomm/services/auth.dart';
import 'package:immaculateflutterecomm/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/Authenticate/razorpay.dart';
import 'models/user.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Ecommerce());
  }
}

class Ecommerce extends StatefulWidget {
  @override
  _EcommerceState createState() => _EcommerceState();
}

class _EcommerceState extends State<Ecommerce> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        lazy: false,
        child: Consumer<User>(
          builder: (BuildContext context, User user, Widget child) {
            print("Consumer UID");
            print(user == null ? "EMPTY" : user.uid);
            return StreamProvider<Customer>.value(
              value:
                  DatabaseService(uid: user == null ? null : user.uid).customer,
              initialData: Customer.initialData(),
              // catchError: (BuildContext context, error) {
              //   print(error.toString());
              //   return Customer.initialData();
              // },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Ecommerce",
                // theme: ThemeData (primaryColor:Colors.redAccent),
                home: Wrapper(),
              ),
            );
          },
        ));
  }
}
