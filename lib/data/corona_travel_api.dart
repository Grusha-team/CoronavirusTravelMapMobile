import 'dart:convert';

import 'package:http/http.dart' as http;

class CoronaTravelApi {
  /// Принимает на вход 2 страны типа [String],
  /// возвращает [List] с маршрутом из 1 страны во 2.
  Future<List> getRoute(String country_1, String country_2) async {
    List countries = [];
    final _url =
        "http://176.119.156.192/GetRoute?start=$country_1&finish=$country_2";
    final _response = await http.get(Uri.encodeFull(_url));
    List _data = json.decode(_response.body);
    for (var i = 0; i < _data.length; i++) {
      countries.add(_data[i]['name']);
    }
    return countries;
  }

  /// Принимает на вход [String] и возвращает информацию о стране ввиде [Map]
  /// с ключами [name] [quarantine] [covidtest].
  Future<Map> getCountryData(String country) async {
    final _url = "http://176.119.156.192/GetCountryData?name=$country";
    final _response = await http.get(Uri.encodeFull(_url));
    Map _data = json.decode(_response.body);
    return _data;
  }
}
