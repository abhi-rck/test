import 'package:coffee_app/models/user.dart';
import 'package:coffee_app/services/database.dart';
import 'package:coffee_app/shared/constants.dart';
import 'package:coffee_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AnonUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userdata,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Form(
            key: _formkey,
            child: Column(
              children: [
                Text(
                  'Update your Coffee settings',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) {
                    setState(() {
                      _currentName = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  onChanged: (value) {
                    setState(() {
                      _currentSugars = value;
                    });
                  },
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                ),
                Slider(
                  max: 900,
                  min: 100,
                  divisions: 8,
                  activeColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _currentStrength = value.round();
                    });
                  },
                ),
                RaisedButton(
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentStrength ?? userData.strength,
                          _currentName ?? userData.name);
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
