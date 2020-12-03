import 'package:corona_travel/blocks/my_panel_bloc/mypanel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FirstTab extends StatefulWidget {
  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  final PanelController _panelController = PanelController();
  final TextEditingController _firstTextEditingController =
      TextEditingController();
  final TextEditingController _secondTextEditingController =
      TextEditingController();
  final String _routeInitial = 'Stay home, stay safe!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyPanelBloc, MyPanelState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is MyPanelFirst) {
            return _buildMyPanel(context, _firstTextEditingController);
          } else if (state is MyPanelSecond) {
            return _buildMyPanel(context, _secondTextEditingController);
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

  SlidingUpPanel _buildMyPanelInitial(BuildContext context, String _text) {
    return SlidingUpPanel(
      maxHeight: 200.0,
      controller: _panelController,
      header: Positioned(
        //* Здесь начинается костыльный завод, исправить его не могу, тк библа не моя
        top: 5.0,
        left: MediaQuery.of(context).size.width / 2 - 20,
        child: Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
      panel: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150.0,
                height: 50.0,
                child: TextFormField(
                  controller: _firstTextEditingController,
                  onTap: () {
                    _panelController.open();
                    BlocProvider.of<MyPanelBloc>(context)
                        .add(FirstMyPanelTapped());
                  },
                ),
              ),
              SizedBox(
                width: 150.0,
                height: 50.0,
                child: TextFormField(
                  controller: _secondTextEditingController,
                  onTap: () {
                    _panelController.open();
                    BlocProvider.of<MyPanelBloc>(context)
                        .add(SecondMyPanelTapped());
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 50.0),
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
          const SizedBox(height: 20.0),
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

  SlidingUpPanel _buildMyPanel(
      BuildContext context, TextEditingController _textEditingController) {
    return SlidingUpPanel(
      onPanelClosed: () {
        FocusScope.of(context).unfocus();
        BlocProvider.of<MyPanelBloc>(context).add(DefaultMyPanelTapped());
      },
      controller: _panelController,
      panel: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                child: TextFormField(
                  controller: _textEditingController,
                  onTap: () {
                    _panelController.open();
                    BlocProvider.of<MyPanelBloc>(context)
                        .add(SecondMyPanelTapped());
                  },
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
}
