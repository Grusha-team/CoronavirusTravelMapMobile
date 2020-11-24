import 'package:corona_travel/presentation/screens/testing.dart';
import 'package:flutter/material.dart';
import 'package:corona_travel/presentation/screens/screens.dart';

class TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
              AutoCompleteDemo(),
              SecondTab(),
            ]),
      ),
    );
  }
}
