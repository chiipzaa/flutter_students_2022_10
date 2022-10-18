part of 'home_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

class HomeState extends Equatable {
  final List<Product> products;
  final FetchStatus status;
  final int count;
  final bool isGrid;

  HomeState({
    this.count = 0,
    this.isGrid = true,
    this.products = const [],
    this.status = FetchStatus.init,
  }) {}

  HomeState copyWith({
    int? count,
    bool? isGrid,
    List<Product>? products,
    FetchStatus? status,
  }) {
    return HomeState(
      count: count ?? this.count,
      isGrid: isGrid ?? this.isGrid,
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        count,
        isGrid,
        products,
        status,
      ];
}
