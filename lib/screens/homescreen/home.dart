import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/screens/homescreen/coffeelist.dart';
import 'package:coffee_app/screens/homescreen/settingshome.dart';
import 'package:coffee_app/services/auth.dart';
import 'package:coffee_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final scaffoldState = GlobalKey<ScaffoldState>();

  void _showSettingsPanel() {
    scaffoldState.currentState.showBottomSheet((context) => Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingForm(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService().coffee,
      child: Scaffold(
        key: scaffoldState,
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('CoffeeApp'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text('Settinga'),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: CoffeeList(),
        ),
      ),
    );
  }
}
