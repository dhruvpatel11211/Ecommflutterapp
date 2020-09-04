import 'package:immaculateflutterecomm/models/customer.dart';
import 'package:immaculateflutterecomm/screens/Authenticate/Authenticate.dart';
import 'package:immaculateflutterecomm/screens/Home/homeScreen.dart';
import 'package:immaculateflutterecomm/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class Wrapper extends StatelessWidget {
  final User user;
  Wrapper({this.user});

  @override
  Widget build(BuildContext context) {
    print("In Wrapper");
    print(user != null ? user.uid : "NULL");
    if (user == null) {
      return Authenticate();
    } else {
      print("Wrapper");
      print(user.uid);
      return HomePage();
    }
  }
}
