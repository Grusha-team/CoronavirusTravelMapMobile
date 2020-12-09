import 'dart:async';
import 'dart:io';

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
        if (event.country1 != '' && event.country2 != '') {
          final _route =
              await CoronaTravelApi().getRoute(event.country1, event.country2);
          final stat =
              await CoronaTravelApi().getCoronaStatistcs(event.country2);
          yield ApiLoadedRoute(route: _route, stat: stat);
        } else {
          if (event.country1 == '') {
            yield ApiError(error: 'Please enter first country');
          } else if (event.country2 == '') {
            yield ApiError(error: 'Please enter second country');
          }
        }
      } on FormatException {
        yield ApiError(error: "Name of country doesn't exist");
      } on SocketException {
        yield ApiError(error: 'Check your internet conection');
      } catch (e) {
        yield ApiError(
            error:
                'You cannot get to the ${event.country2} from ${event.country1}');
      }
    }
  }
}
