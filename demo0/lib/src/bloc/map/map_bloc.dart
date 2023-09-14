import 'package:bloc/bloc.dart';
import 'package:demo0/src/services/network_service.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState(currentPosition: const LatLng(0, 0))) {
    on<MapEventSubmitLocation>((event, emit) {
      emit(state.copyWith(currentPosition: event.position!));
      NetworkService().submitLocation(event.position!);
    });
  }
}
