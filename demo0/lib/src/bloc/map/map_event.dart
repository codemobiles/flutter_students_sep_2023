part of 'map_bloc.dart';

abstract class MapEvent {
  const MapEvent();
}

class MapEventSubmitLocation extends MapEvent {
  final LatLng? position;
  const MapEventSubmitLocation({this.position});
}
