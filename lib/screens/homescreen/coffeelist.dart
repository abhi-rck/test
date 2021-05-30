import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/screens/homescreen/coffeetile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final coffee = Provider.of<List<Coffee>>(context);

    return ListView.builder(
      itemCount: coffee != null ? coffee.length : 0,
      itemBuilder: (context, index) {
        return CoffeeTile(
          coffee: coffee[index],
        );
      },
    );
  }
}
