import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:demo0/src/constants/network_api.dart';
import 'package:demo0/src/models/product.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEventLoadProducts>((event, emit) async {
      emit(state.copyWith(products: [], status: FetchStatus.fetching));
      await Future.delayed(const Duration(seconds: 1));

      final dio = Dio();
      final result = await dio.get(NetworkAPI.baseURL + "/products");
      final products = productFromJson(jsonEncode(result.data));
      emit(state.copyWith(products: products, status: FetchStatus.success));
    });
  }
}
