import 'package:corona_travel/blocks/my_panel_bloc/mypanel_bloc.dart';
import 'package:corona_travel/data/corona_travel_api.dart';
import 'package:corona_travel/data/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import '../../blocks/my_panel_bloc/mypanel_bloc.dart';
import '../../data/corona_travel_api.dart';

class MainTab extends StatefulWidget {
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  final PanelController _panelController = PanelController();
  TextEditingController _bufferTextEditController = TextEditingController();
  TextEditingController _firstTextEditingController = TextEditingController();
  TextEditingController _secondTextEditingController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Country>> key2 = GlobalKey();
  List<Country> countries = <Country>[];
  final String _routeInitial = '';

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
      appBar: AppBar(
        title: const Text('CoronaTravelMap'),
        centerTitle: true,
      ),
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
            return _buildMyPanelLoaded(
                context, state.route.toString(), state.stat);
          } else if (state is ApiError) {
            return _buildMyPanelError(context, state.error);
          }
        },
      ),
    );
  }

  SlidingUpPanel _buildMyPanelLoading() {
    return SlidingUpPanel(
      maxHeight: 130.0,
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

  SlidingUpPanel _buildMyPanelLoaded(
    BuildContext context,
    String _text,
    Map _stat,
  ) {
    final _circularData = <List<CircularStackEntry>>[
      <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(
                double.parse('${_stat['deaths']}'), const Color(0xFF9FA8DA),
                rankKey: 'D1'),
            CircularSegmentEntry(
                double.parse('${_stat['cases']}'), const Color(0xFFF44336),
                rankKey: 'D2'),
            CircularSegmentEntry(
                double.parse('${_stat['recovered']}'), Colors.green,
                rankKey: 'D3'),
          ],
          rankKey: 'CircularData',
        )
      ]
    ];
    return SlidingUpPanel(
      minHeight: 130.0,
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
          const SizedBox(height: 10.0),
          Text(_text.substring(1, _text.length - 1)),
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
                  if (_firstTextEditingController != null &&
                      _secondTextEditingController != null) {
                    BlocProvider.of<MyPanelBloc>(context).add(
                      ApiGetRoute(
                          country1: _firstTextEditingController.text,
                          country2: _secondTextEditingController.text),
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  _stat['country'].toString(),
                  textScaleFactor: 2.5,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: const Color(0xFFF44336),
                    width: 15.0,
                    height: 15.0,
                  ),
                  const Text(
                    'Кол-во заболевших:',
                    textScaleFactor: 1.7,
                  ),
                  Text(
                    _stat['cases'].toString(),
                    textScaleFactor: 1.7,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: const Color(0xFF9FA8DA),
                    width: 15.0,
                    height: 15.0,
                  ),
                  const Text(
                    'Кол-во погибших:',
                    textScaleFactor: 1.7,
                  ),
                  Text(_stat['deaths'].toString(), textScaleFactor: 1.7),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: Colors.green,
                    width: 15.0,
                    height: 15.0,
                  ),
                  const Text(
                    'Ко-во выздоровевших:',
                    textScaleFactor: 1.7,
                  ),
                  Text(_stat['recovered'].toString(), textScaleFactor: 1.7),
                ],
              ),
              Center(
                child: AnimatedCircularChart(
                  size: const Size(200.0, 200.0),
                  initialChartData: _circularData[0],
                  chartType: CircularChartType.Pie,
                ),
              ),
            ],
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: 200.0,
          width: 200.0,
          color: Colors.yellow,
        ),
      ),
    );
  }

  SlidingUpPanel _buildMyPanelInitial(
    BuildContext context,
    String _text,
  ) {
    return SlidingUpPanel(
      maxHeight: 100.0,
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
                  if (_firstTextEditingController != null &&
                      _secondTextEditingController != null) {
                    BlocProvider.of<MyPanelBloc>(context).add(
                      ApiGetRoute(
                          country1: _firstTextEditingController.text,
                          country2: _secondTextEditingController.text),
                    );
                  }
                },
              ),
            ],
          ),
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

  SlidingUpPanel _buildMyPanelError(
    BuildContext context,
    String _text,
  ) {
    return SlidingUpPanel(
      minHeight: 130.0,
      maxHeight: 130.0,
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
          const SizedBox(height: 10.0),
          Text(_text),
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
                  if (_firstTextEditingController != null &&
                      _secondTextEditingController != null) {
                    BlocProvider.of<MyPanelBloc>(context).add(
                      ApiGetRoute(
                          country1: _firstTextEditingController.text,
                          country2: _secondTextEditingController.text),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
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
        if (_firstTextEditingController != null &&
            _secondTextEditingController != null) {
          BlocProvider.of<MyPanelBloc>(context).add(
            ApiGetRoute(
                country1: _firstTextEditingController.text,
                country2: _secondTextEditingController.text),
          );
        }
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
                          if (_secondTextEditingController != null) {
                            BlocProvider.of<MyPanelBloc>(context).add(
                              ApiGetRoute(
                                  country1: _firstTextEditingController.text,
                                  country2: _secondTextEditingController.text),
                            );
                          }
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
        if (_firstTextEditingController != null &&
            _secondTextEditingController != null) {
          BlocProvider.of<MyPanelBloc>(context).add(
            ApiGetRoute(
                country1: _firstTextEditingController.text,
                country2: _secondTextEditingController.text),
          );
        }
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
                        if (_firstTextEditingController != null) {
                          BlocProvider.of<MyPanelBloc>(context).add(
                            ApiGetRoute(
                                country1: _firstTextEditingController.text,
                                country2: _secondTextEditingController.text),
                          );
                        }
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
