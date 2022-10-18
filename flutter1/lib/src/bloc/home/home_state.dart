part of 'home_bloc.dart';

class HomeState extends Equatable {
  HomeState({this.count = 0}){}
  int count = 0;

  HomeState copyWith(int count){
    return HomeState(count: )
  }

  @override
  List<Object> get props => [count];
}
