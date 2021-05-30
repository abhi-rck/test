import 'package:coffee_app/models/user.dart';
import 'package:coffee_app/screens/wrapper.dart';
import 'package:coffee_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder();
  }
}

class Builder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<AnonUser>.value(
            value: AuthService().user,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            ),
          );
        }
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('Setting Connection'),
            ),
            body: Text('New'),
          ),
        );
      },
    );
  }
}
