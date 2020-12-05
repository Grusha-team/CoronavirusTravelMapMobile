import 'package:corona_travel/blocks/my_panel_bloc/mypanel_bloc.dart';
import 'package:corona_travel/data/corona_travel_api.dart';
import 'package:corona_travel/data/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class FirstTab extends StatefulWidget {
  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  final PanelController _panelController = PanelController();
  TextEditingController _bufferTextEditController = TextEditingController();
  TextEditingController _firstTextEditingController = TextEditingController();
  TextEditingController _secondTextEditingController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Country>> key2 = GlobalKey();
  List<Country> countries = <Country>[];

  final String _routeInitial = 'Stay home, stay safe!';

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  void getCountries() async {
    countries = await CoronaTravelApi().getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyPanelBloc, MyPanelState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is MyPanelFirst) {
            return _buildMyPanelFirst(context);
          } else if (state is MyPanelSecond) {
            return _buildMyPanelSecond(context);
          } else if (state is MyPanelInitial) {
            return _buildMyPanelInitial(context, _routeInitial);
          } else if (state is ApiLoading) {
            return _buildMyPanelLoading();
          } else if (state is ApiLoadedRoute) {
            return _buildMyPanelInitial(context, state.route.toString());
          } else if (state is ApiError) {
            return _buildMyPanelInitial(context, state.error);
          }
        },
      ),
    );
  }

  SlidingUpPanel _buildMyPanelLoading() {
    return SlidingUpPanel(
      maxHeight: 200.0,
      controller: _panelController,
      panel: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
        ],
      ),
      body: Container(
        height: 200.0,
        width: 200.0,
        color: Colors.yellow,
      ),
    );
  }

  SlidingUpPanel _buildMyPanelInitial(
    BuildContext context,
    String _text,
  ) {
    return SlidingUpPanel(
      maxHeight: 200.0,
      controller: _panelController,
      panel: Column(
        children: [
          const SizedBox(height: 5.0),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(12.0))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150.0,
                height: 70.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'From',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    controller: _firstTextEditingController,
                    onTap: () {
                      _panelController.open();
                      BlocProvider.of<MyPanelBloc>(context)
                          .add(FirstMyPanelTapped());
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              SizedBox(
                width: 150.0,
                height: 70.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'To',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    controller: _secondTextEditingController,
                    onTap: () {
                      _panelController.open();
                      BlocProvider.of<MyPanelBloc>(context)
                          .add(SecondMyPanelTapped());
                    },
                  ),
                ),
              ),
              IconButton(
                padding: const EdgeInsets.only(top: 15.0, right: 10.0),
                icon: const Icon(Icons.compare_arrows, size: 30.0),
                onPressed: () {
                  setState(() {
                    _bufferTextEditController = _firstTextEditingController;
                    _firstTextEditingController = _secondTextEditingController;
                    _secondTextEditingController = _bufferTextEditController;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<MyPanelBloc>(context).add(
                ApiGetRoute(
                    country1: _firstTextEditingController.text,
                    country2: _secondTextEditingController.text),
              );
            },
            child: const Text('Поехали'),
          ),
          const SizedBox(height: 10.0),
          Text(_text),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          BlocProvider.of<MyPanelBloc>(context).add(DefaultMyPanelTapped());
        },
        child: Container(
          height: 200.0,
          width: 200.0,
          color: Colors.yellow,
        ),
      ),
    );
  }

  SlidingUpPanel _buildMyPanelFirst(BuildContext context) {
    return SlidingUpPanel(
      onPanelClosed: () {
        FocusScope.of(context).unfocus();
        BlocProvider.of<MyPanelBloc>(context).add(DefaultMyPanelTapped());
      },
      controller: _panelController,
      panel: Column(
        children: [
          const SizedBox(height: 5.0),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(12.0))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 10.0, right: 10.0),
                      child: AutoCompleteTextField<Country>(
                        key: key2,
                        clearOnSubmit: false,
                        controller: _firstTextEditingController,
                        suggestions: countries,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 20.0),
                        decoration: InputDecoration(
                          labelText: 'From',
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
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
                          _firstTextEditingController.text = item.name.trim();
                          BlocProvider.of<MyPanelBloc>(context)
                              .add(DefaultMyPanelTapped());
                        },
                        itemBuilder: (context, item) {
                          return Text(
                            item.name.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20.0),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _panelController.close();
          BlocProvider.of<MyPanelBloc>(context).add(DefaultMyPanelTapped());
        },
        child: Container(
          height: 200.0,
          width: 200.0,
          color: Colors.yellow,
        ),
      ),
    );
  }

  SlidingUpPanel _buildMyPanelSecond(BuildContext context) {
    return SlidingUpPanel(
      onPanelClosed: () {
        FocusScope.of(context).unfocus();
        BlocProvider.of<MyPanelBloc>(context).add(DefaultMyPanelTapped());
      },
      controller: _panelController,
      panel: Column(
        children: [
          const SizedBox(height: 5.0),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 10.0, right: 10.0),
                    child: AutoCompleteTextField<Country>(
                      key: key2,
                      clearOnSubmit: false,
                      controller: _secondTextEditingController,
                      suggestions: countries,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      decoration: InputDecoration(
                        labelText: 'To',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
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
                        _secondTextEditingController.text = item.name.trim();
                        BlocProvider.of<MyPanelBloc>(context)
                            .add(DefaultMyPanelTapped());
                      },
                      itemBuilder: (context, item) {
                        return Text(
                          item.name.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _panelController.close();
          BlocProvider.of<MyPanelBloc>(context).add(DefaultMyPanelTapped());
        },
        child: Container(
          height: 200.0,
          width: 200.0,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
