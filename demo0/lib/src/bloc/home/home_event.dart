part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeEventLoadProducts extends HomeEvent {}

// Toggle display
class HomeEventToggleDisplay extends HomeEvent {}
