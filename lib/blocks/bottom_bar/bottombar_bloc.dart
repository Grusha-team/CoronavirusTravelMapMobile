import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottombar_event.dart';
part 'bottombar_state.dart';

class BottombarBloc extends Bloc<BottombarEvent, BottombarState> {
  BottombarBloc() : super(ShowFirstPage());

  @override
  Stream<BottombarState> mapEventToState(
    BottombarEvent event,
  ) async* {
    if (event is FirstItemTapped) {
      yield ShowFirstPage();
    } else if (event is SecondItemTapped) {
      yield ShowSecondPage();
    } else if (event is ThirdItemTapped) {
      yield ShowThirdPage();
    }
  }
}
