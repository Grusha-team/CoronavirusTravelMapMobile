part of 'mypanel_bloc.dart';

abstract class MyPanelState extends Equatable {
  const MyPanelState();

  @override
  List<Object> get props => [];
}

class MyPanelInitial extends MyPanelState {}

class MyPanelFirst extends MyPanelState {}

class MyPanelSecond extends MyPanelState {}

class ApiLoading extends MyPanelState {}

class ApiLoadedRoute extends MyPanelState {
  final List route;
  ApiLoadedRoute({@required this.route});
}

class ApiError extends MyPanelState {
  final String error;

  ApiError({this.error});
}
