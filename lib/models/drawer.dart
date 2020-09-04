import 'package:flutter/material.dart';

String firstName = "Dhruv";
String email = "dhruvpatel11611@gmail.com";
class drawer extends StatelessWidget {
  const drawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Hello, $firstName'),
            accountEmail: Text(email),
            currentAccountPicture: null,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Edit Profile'),
              leading: Icon(Icons.person),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Shop by Category'),
              leading: Icon(Icons.category),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('My WishList'),
              leading: Icon(Icons.favorite),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('My Orders'),
              leading: Icon(Icons.store),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('My Subscriptions'),
              leading: Icon(Icons.redeem),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Your Notifications'),
              leading: Icon(Icons.notifications_active),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('About Us'),
              leading: Icon(Icons.help_outline),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Help and Support'),
              leading: Icon(Icons.supervisor_account),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }
}