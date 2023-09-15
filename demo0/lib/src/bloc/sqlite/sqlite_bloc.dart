import 'package:demo0/src/app.dart';
import 'package:demo0/src/models/sqlite_model.dart';
import 'package:demo0/src/services/database_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sqlite_event.dart';
part 'sqlite_state.dart';

class SqliteBloc extends Bloc<SqliteEvent, SqliteState> {
  SqliteBloc()
      : super(const SqliteState(
          status: SqliteStatus.init,
          historyArray: [],
        )) {
    //  insert
    on<SqliteEventInsert>((event, emit) async {
      try {
        emit(state.copyWith(status: SqliteStatus.fetching));
        await Future.delayed(const Duration(milliseconds: 200));
        await DatabaseService().insert(event.payload);
        emit(state.copyWith(status: SqliteStatus.success));
        navigatorState.currentContext!
            .read<SqliteBloc>()
            .add(SqliteEventQuery());
      } catch (e) {
        emit(state.copyWith(status: SqliteStatus.failed));
      }
    });

    // query
    on<SqliteEventQuery>((event, emit) async {
      try {
        emit(state.copyWith(status: SqliteStatus.fetching));
        await Future.delayed(const Duration(milliseconds: 200));
        final result = await DatabaseService().query();

        emit(
            state.copyWith(status: SqliteStatus.success, historyArray: result));
      } catch (e) {
        emit(state.copyWith(status: SqliteStatus.failed, historyArray: []));
      }
    });
  }
}
