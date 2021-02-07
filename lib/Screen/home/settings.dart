import 'package:flutter/material.dart';
import 'package:net_ninja_coffee/Service/database.dart';
import 'package:net_ninja_coffee/Shared/constants.dart';
import 'package:net_ninja_coffee/Shared/loading.dart';
import 'package:net_ninja_coffee/models/user.dart';
import 'package:net_ninja_coffee/models/userData.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _curname;
  String _cursugars;
  int _curStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).getUserData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData udata = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your coffee preference',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      initialValue: udata.name,
                      decoration: TextInputDecoration,
                      validator: (val) => val.isEmpty ? 'Enter name' : null,
                      onChanged: (val) {
                        setState(() {
                          _curname = val;
                        });
                      }),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                      decoration: TextInputDecoration,
                      value: _cursugars ?? udata.sugars,
                      items: sugars.map((amount) {
                        return DropdownMenuItem(
                            value: amount, child: Text('$amount sugars'));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _cursugars = val;
                        });
                      }),
                  Slider(
                    value: (_curStrength ?? udata.strength).toDouble(),
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor: Colors.brown[_curStrength ?? udata.strength],
                    inactiveColor: Colors.brown[_curStrength ?? udata.strength],
                    onChanged: (val) {
                      setState(() {
                        _curStrength = val.round();
                      });
                    },
                  ),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: udata.uid).updateUserData(
                              _cursugars ?? udata.sugars,
                              _curname ?? udata.name,
                              _curStrength ?? udata.strength);
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
