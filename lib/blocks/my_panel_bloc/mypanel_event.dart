part of 'mypanel_bloc.dart';

abstract class MyPanelEvent extends Equatable {
  const MyPanelEvent();

  @override
  List<Object> get props => [];
}

class DefaultMyPanelTapped extends MyPanelEvent {}

class FirstMyPanelTapped extends MyPanelEvent {}

class SecondMyPanelTapped extends MyPanelEvent {}
