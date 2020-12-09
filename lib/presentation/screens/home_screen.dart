import 'package:corona_travel/blocks/my_panel_bloc/mypanel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MyPanelBloc>(
        create: (context) => MyPanelBloc(),
        child: MainTab(),
      ),
    );
  }
}
