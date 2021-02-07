import 'package:flutter/material.dart';
import 'package:net_ninja_coffee/Screen/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:net_ninja_coffee/Service/auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser>.value(
      value: AuthService().users,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
