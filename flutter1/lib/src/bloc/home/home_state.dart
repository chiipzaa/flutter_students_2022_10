part of 'home_bloc.dart';

class HomeState extends Equatable {
  HomeState({this.count = 0, this.isGrid = true}) {}
  final int count;
  final bool isGrid;

  HomeState copyWith({int? count, bool? isGrid}) {
    return HomeState(
      count: count ?? this.count,
      isGrid: isGrid ?? this.isGrid,
    );
  }

  @override
  List<Object> get props => [count, isGrid];
}
