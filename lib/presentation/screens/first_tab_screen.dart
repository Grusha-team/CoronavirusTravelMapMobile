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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyPanelBloc, MyPanelState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is MyPanelFirst) {
            return SlidingUpPanel(
              onPanelClosed: () => BlocProvider.of<MyPanelBloc>(context)
                  .add(DefaultMyPanelTapped()),
              controller: _panelController,
              panel: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        color: Colors.blue,
                        height: 100.0,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                )
              ]),
              body: GestureDetector(
                onTap: () {
                  _panelController.close();
                  BlocProvider.of<MyPanelBloc>(context)
                      .add(DefaultMyPanelTapped());
                },
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  color: Colors.yellow,
                ),
              ),
            );
          } else if (state is MyPanelSecond) {
            return SlidingUpPanel(
              onPanelClosed: () => BlocProvider.of<MyPanelBloc>(context)
                  .add(DefaultMyPanelTapped()),
              controller: _panelController,
              panel: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        color: Colors.red,
                        height: 100.0,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                )
              ]),
              body: GestureDetector(
                onTap: () {
                  _panelController.close();
                  BlocProvider.of<MyPanelBloc>(context)
                      .add(DefaultMyPanelTapped());
                },
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  color: Colors.yellow,
                ),
              ),
            );
          } else if (state is MyPanelInitial) {
            return SlidingUpPanel(
              maxHeight: 200.0,
              controller: _panelController,
              panel: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _panelController.open();
                        BlocProvider.of<MyPanelBloc>(context)
                            .add(FirstMyPanelTapped());
                      },
                      child: Container(
                        color: Colors.blue,
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _panelController.open();
                        BlocProvider.of<MyPanelBloc>(context)
                            .add(SecondMyPanelTapped());
                      },
                      child: Container(
                        color: Colors.red,
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                  ],
                )
              ]),
              body: GestureDetector(
                onTap: () {
                  BlocProvider.of<MyPanelBloc>(context)
                      .add(DefaultMyPanelTapped());
                },
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  color: Colors.yellow,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
