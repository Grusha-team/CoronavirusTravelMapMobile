import 'dart:convert';

import 'package:corona_travel/data/models/country.dart';
import 'package:http/http.dart' as http;

class CoronaTravelApi {
  /// Принимает на вход 2 страны типа [String],
  /// возвращает [List] с маршрутом из 1 страны во 2.
  Future<List> getRoute(String country_1, String country_2) async {
    final _countries = [];
    final _url =
        'http://176.119.156.192/GetRoute?start=$country_1&finish=$country_2';
    final _response = await http.get(Uri.encodeFull(_url));
    final _data = json.decode(_response.body) as List<dynamic>;
    for (var i = 0; i < _data.length; i++) {
      _countries.add(_data[i]['name']);
    }
    return _countries;
  }

  /// Принимает на вход [String] и возвращает информацию о стране ввиде [Map]
  /// с ключами [name] [quarantine] [covidtest].
  Future<Map> getCountryData(String country) async {
    final _url = 'http://176.119.156.192/GetCountryData?name=$country';
    final _response = await http.get(Uri.encodeFull(_url));
    final _data = json.decode(_response.body);
    return _data;
  }

  /// Возвращает [List] из всех стран.
  void getAllCountries() async {
    try {
      final _response =
          await http.get('http://176.119.156.192/GetAllCountries');
      if (_response.statusCode == 200) {
      } else {
        print('Error getting countries.');
      }
    } catch (e) {
      print('Error');
    }
  }

  dynamic loadCountries(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Country>((json) => Country.fromJson(json)).toList();
  }

  Future<Map> getCoronaStatistcs(String country) async {
    final _url = 'https://coronavirus-19-api.herokuapp.com/countries/$country';
    final _response = await http.get(Uri.encodeFull(_url));
    final _data = json.decode(_response.body) as Map<String, dynamic>;
    return _data;
  }
}
