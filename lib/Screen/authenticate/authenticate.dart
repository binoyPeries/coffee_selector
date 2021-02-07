import 'package:flutter/material.dart';
import 'package:net_ninja_coffee/Screen/authenticate/register.dart';
import 'package:net_ninja_coffee/Screen/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void ToggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Signin(
        toggleView: ToggleView,
      );
    } else {
      return Register(
        toggleView: ToggleView,
      );
    }
  }
}
