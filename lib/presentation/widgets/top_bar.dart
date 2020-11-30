import 'package:corona_travel/blocks/my_panel_bloc/mypanel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:corona_travel/presentation/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.search)),
                    Tab(icon: Icon(Icons.assessment)),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BlocProvider<MyPanelBloc>(
                  create: (context) => MyPanelBloc(),
                  child: FirstTab(),
                ),
                SecondTab(),
              ]),
        ),
      ),
    );
  }
}
