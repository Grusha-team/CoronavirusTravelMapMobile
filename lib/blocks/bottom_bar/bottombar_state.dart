part of 'bottombar_bloc.dart';

abstract class BottombarState extends Equatable {
  @override
  List<Object> get props => [];

}

class ShowFirstPage extends BottombarState {
  final int itemIndex = 0;
}

class ShowSecondPage extends BottombarState {
  final int itemIndex = 1;
}

class ShowThirdPage extends BottombarState {
  final int itemIndex = 2;
}
