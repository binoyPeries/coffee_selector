import 'package:flutter/material.dart';
import 'package:net_ninja_coffee/Screen/authenticate/authenticate.dart';
import 'package:net_ninja_coffee/Screen/home/home.dart';
import 'package:net_ninja_coffee/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(
        context); //specifying the stream that need to listen to
    print(user);
    //return either home or auth
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
