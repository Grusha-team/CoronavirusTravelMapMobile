import 'package:flutter/foundation.dart';

class Country {
  @required
  String name;
  String quarantine;
  String covidtest;
  Country({this.name, this.quarantine, this.covidtest});

  factory Country.fromJson(Map<String, dynamic> parsedJson) {
    return Country(
      name: parsedJson['name'] as String,
      quarantine: parsedJson['quarantine'] as String,
      covidtest: parsedJson['covidtest'] as String,
    );
  }
}
