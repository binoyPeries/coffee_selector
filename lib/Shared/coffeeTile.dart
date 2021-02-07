import 'package:flutter/material.dart';
import 'package:net_ninja_coffee/models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;

  const CoffeeTile({this.coffee});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('Assets/coffee_icon.png'),
            radius: 25.0,
            backgroundColor: Colors.brown[coffee.strength],
          ),
          title: Text(coffee.name),
          subtitle: Text(' Takes ${coffee.sugars}'),
        ),
      ),
    );
  }
}
