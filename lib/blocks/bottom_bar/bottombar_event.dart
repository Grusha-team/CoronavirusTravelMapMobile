part of 'bottombar_bloc.dart';

abstract class BottombarEvent extends Equatable {
  const BottombarEvent();

  @override
  List<Object> get props => [];
}

class FirstItemTapped extends BottombarEvent {}

class SecondItemTapped extends BottombarEvent {}

class ThirdItemTapped extends BottombarEvent {}
