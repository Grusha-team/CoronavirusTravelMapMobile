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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyPanelBloc, MyPanelState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is MyPanelFirst) {
            return SlidingUpPanel(
              onPanelClosed: () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<MyPanelBloc>(context)
                    .add(DefaultMyPanelTapped());
              },
              controller: _panelController,
              panel: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 100.0,
                      child: TextFormField(
                        controller: _firstTextEditingController,
                        onTap: () {
                          _panelController.open();
                          BlocProvider.of<MyPanelBloc>(context)
                              .add(FirstMyPanelTapped());
                        },
                      ),
                    ),
                  ],
                )
              ]),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
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
              onPanelClosed: () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<MyPanelBloc>(context)
                    .add(DefaultMyPanelTapped());
              },
              controller: _panelController,
              panel: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 100.0,
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
                )
              ]),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();

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
                  RaisedButton(
                    onPressed: () {},
                    child: const Text('Поехали'),
                  ),
                  const SizedBox(height: 40.0),
                  const Text('Stay home, stay safe!')
                ],
              ),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
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
