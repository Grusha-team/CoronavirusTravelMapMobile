import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:corona_travel/data/corona_travel_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'mypanel_event.dart';
part 'mypanel_state.dart';

class MyPanelBloc extends Bloc<MyPanelEvent, MyPanelState> {
  MyPanelBloc() : super(MyPanelInitial());

  @override
  Stream<MyPanelState> mapEventToState(
    MyPanelEvent event,
  ) async* {
    if (event is FirstMyPanelTapped) {
      yield MyPanelFirst();
    } else if (event is SecondMyPanelTapped) {
      yield MyPanelSecond();
    } else if (event is DefaultMyPanelTapped) {
      yield MyPanelInitial();
    } else if (event is ApiGetRoute) {
      yield ApiLoading();
      try {
        //TODO add cool error handling
        final _route =
            await CoronaTravelApi().getRoute(event.country1, event.country2);
        yield ApiLoadedRoute(route: _route);
      } on FormatException {
        yield ApiError(error: "Name of country doesn't exist");
      } catch (e) {
        yield ApiError(error: 'Error');
      }
    }
  }
}
