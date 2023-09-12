part of 'home_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

sealed class HomeState extends Equatable {
  const HomeState({
    this.products = const [],
    this.status = FetchStatus.init,
    this.isGrid = true,
  });

  final List<Product> products;
  final FetchStatus status;
  final bool isGrid;

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}
