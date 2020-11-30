part of 'mypanel_bloc.dart';

abstract class MyPanelState extends Equatable {
  const MyPanelState();

  @override
  List<Object> get props => [];
}

class MyPanelInitial extends MyPanelState {}

class MyPanelFirst extends MyPanelState {}

class MyPanelSecond extends MyPanelState {}