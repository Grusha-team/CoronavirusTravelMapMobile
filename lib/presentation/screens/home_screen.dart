import 'package:corona_travel/blocks/bottom_bar/bottombar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corona_travel/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<BottombarBloc>(
        create: (context) => BottombarBloc(),
        child: BottomBarWidget(),
      ),
    );
  }
}
