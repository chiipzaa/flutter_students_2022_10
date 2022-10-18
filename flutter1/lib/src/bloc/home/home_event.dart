part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// Add Event
class HomeEvent_Add extends HomeEvent {}

// Delete Event
class HomeEvent_Delete extends HomeEvent {}
