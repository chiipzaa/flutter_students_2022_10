import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter1/src/models/Product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    // Add
    on<HomeEvent_Add>((event, emit) {
        emit(state.copyWith(count: state.count+1));
    });

    // Delete
    on<HomeEvent_Delete>((event, emit) {
      emit(state.copyWith(count: state.count-1));
    });

    // Toggle Grid or List
    on<HomeEvent_ToggleGridAndListView>((event, emit) {
      emit(state.copyWith(isGrid: !state.isGrid));
    });
  }
}
