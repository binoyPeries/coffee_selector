import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:net_ninja_coffee/Screen/home/coffeelist.dart';
import 'package:net_ninja_coffee/Screen/home/settings.dart';
import 'package:net_ninja_coffee/Service/auth.dart';
import 'package:net_ninja_coffee/models/coffee.dart';
import 'package:provider/provider.dart';
import 'package:net_ninja_coffee/Service/database.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSettings() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: SettingsForm(),
            );
          });
    }

    final AuthService _auth = AuthService();
    return StreamProvider<List<Coffee>>.value(
      //this is in the databse file
      value: DatabaseService().getcoffees,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Coffee Selector"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.Signout();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettings(),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: CoffeeList()),
      ),
    );
  }
}
