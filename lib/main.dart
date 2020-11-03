import 'package:corona_travel/data/corona_travel_api.dart';
import 'package:corona_travel/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  var corona = CoronaTravelApi();
  var route = await corona.getRoute("USA", "Britain");
  print(route);
  runApp(
    HomeScreen(),
  );
}
