part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();
  
  @override
  List<Object> get props => [];
}

final class MapInitial extends MapState {}
