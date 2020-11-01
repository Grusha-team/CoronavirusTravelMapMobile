import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//TODO remove trash

class CoronaSerivce extends ChangeNotifier {
  String country1 = "Canada";
  String country2 = "Estonia";

  String get url =>
      "http://176.119.156.192/GetRoute?start=$country1&finish=$country2";

  var _response;
  var textResponse = "Wainting";

  String display1 = "From";
  String display2 = "To";

  List<dynamic> countries = [];
  List data;

  Future getData(List data) async {
    _response = await http.get(Uri.encodeFull(url));
    data = json.decode(_response.body);

    for (var i = 0; i < data.length; i++) {
      countries.add(data[i]['name']);
    }
    display1 = data[0]['name'];
    display2 = data[data.length - 1]['name'];
    textResponse = countries.join(',');

    notifyListeners();
  }
}
