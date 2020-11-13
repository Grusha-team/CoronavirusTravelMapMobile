import 'package:corona_travel/blocks/bottom_bar/bottombar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottombarBloc _bottombarBloc =
        BlocProvider.of<BottombarBloc>(context);

    return BlocBuilder<BottombarBloc, BottombarState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is ShowFirstPage) {
          return buildPage(state.itemIndex, _bottombarBloc, firstBody());
        }
        if (state is ShowSecondPage) {
          return buildPage(state.itemIndex, _bottombarBloc, secondBody());
        }
        if (state is ShowThirdPage) {
          return buildPage(state.itemIndex, _bottombarBloc, thirdBody());
        }
      },
    );
  }

  Scaffold buildPage(
      int currentIndex, BottombarBloc bottombarBloc, Widget body) {
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) bottombarBloc.add(FirstItemTapped());
          if (index == 1) bottombarBloc.add(SecondItemTapped());
          if (index == 2) bottombarBloc.add(ThirdItemTapped());
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: "First",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: "Second",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: "Third",
          )
        ],
      ),
    );
  }

  Scaffold firstBody() {
    return const Scaffold(
      body: Center(
        child: Text("1"),
      ),
    );
  }

  Scaffold secondBody() {
    return const Scaffold(
      body: Center(
        child: Text("2"),
      ),
    );
  }

  Scaffold thirdBody() {
    return const Scaffold(
      body: Center(
        child: Text("3"),
      ),
    );
  }
}
