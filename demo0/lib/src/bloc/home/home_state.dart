part of 'home_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

class HomeState extends Equatable {
  const HomeState({
    this.products = const [],
    this.status = FetchStatus.init,
    this.isGrid = true,
  });

  final List<Product> products;
  final FetchStatus status;
  final bool isGrid;

  HomeState copyWith({
    List<Product>? products,
    FetchStatus? status,
    bool? isGrid,
  }) {
    return HomeState(
        products: products ?? this.products,
        status: status ?? this.status,
        isGrid: isGrid ?? this.isGrid);
  }

  @override
  List<Object> get props => [products, status, isGrid];
}

final class HomeInitial extends HomeState {}
