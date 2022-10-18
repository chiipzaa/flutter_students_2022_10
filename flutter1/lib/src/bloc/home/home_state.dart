part of 'home_bloc.dart';

class HomeState extends Equatable {

  HomeState({this.count = 0}){}
  final int count;

  HomeState copyWith({int? count}){
    return HomeState(count: count ?? this.count);
  }

  @override
  List<Object> get props => [count];
}
