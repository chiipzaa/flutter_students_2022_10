import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter1/src/services/network_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState(currentPosition: LatLng(13.7462463, 100.5325515))) {
    on<MapEvent_SubmitLocation>((event, emit) {
        emit(state.copyWith(position: event.position));
        NetworkService().submitLocation(event.position!);
    });
  }
}
