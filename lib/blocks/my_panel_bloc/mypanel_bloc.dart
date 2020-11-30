import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    }
  }
}
