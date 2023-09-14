part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({required this.currentPosition});

  final LatLng currentPosition;

  MapState copyWith({LatLng? currentPosition}) {
    return MapState(currentPosition: currentPosition ?? this.currentPosition);
  }

  @override
  List<Object> get props => [currentPosition];
}
