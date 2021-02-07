import 'package:flutter/material.dart';
import 'package:net_ninja_coffee/Shared/coffeeTile.dart';
import 'package:net_ninja_coffee/models/coffee.dart';
import 'package:provider/provider.dart';

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final coffees = Provider.of<List<Coffee>>(context) ?? [];

    return ListView.builder(
        itemCount: coffees.length,
        itemBuilder: (context, index) {
          return CoffeeTile(coffee: coffees[index]);
        });
  }
}
