import 'package:corona_travel/data/corona_travel_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:corona_travel/data/models/country.dart';

class AutoCompleteDemo extends StatefulWidget {
  final String title = 'AutoComplete Demo';

  @override
  _AutoCompleteDemoState createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoCompleteDemo> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Country>> key = GlobalKey();
  static List<Country> countries = <Country>[];
  bool loading = true;

  void getUsers() async {
    try {
      final response = await http.get('http://176.119.156.192/GetAllCountries');
      if (response.statusCode == 200) {
        countries = loadUsers(response.body);
        print('Users: ${countries.length}');
        setState(() {
          loading = false;
        });
      } else {
        print('Error getting users.');
      }
    } catch (e) {
      print('Error getting users.');
    }
  }

  static List<Country> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Country>((json) => Country.fromJson(json)).toList();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  //TODO раскидать все на логику и на UI

  Widget row(Country countries) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                countries.name,
                style: const TextStyle(fontSize: 16.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'covidtest: ' + countries.covidtest,
                  ),
                  Text(
                    'quarantine: ' + countries.quarantine,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          height: 0.0,
          color: Colors.black,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          loading
              ? const CircularProgressIndicator()
              : searchTextField = AutoCompleteTextField<Country>(
                  key: key,
                  clearOnSubmit: false,
                  suggestions: countries,
                  style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                    hintText: 'Search Name',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  itemFilter: (item, query) {
                    return item.name
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  },
                  itemSorter: (a, b) {
                    return a.name.compareTo(b.name);
                  },
                  itemSubmitted: (item) {
                    setState(() {
                      searchTextField.textField.controller.text = item.name;
                    });
                  },
                  itemBuilder: (context, item) {
                    // ui for the autocompelete row
                    return row(item);
                  },
                ),
        ],
      ),
    );
  }
}
