part of 'sqlite_bloc.dart';

enum SqliteStatus { fetching, success, failed, init }

class SqliteState extends Equatable {
  final SqliteStatus status;
  final List<Map> historyArray;

  const SqliteState({
    required this.status,
    required this.historyArray,
  });

  SqliteState copyWith({
    SqliteStatus? status,
    List<Map>? historyArray,
  }) {
    return SqliteState(
      status: status ?? this.status,
      historyArray: historyArray ?? this.historyArray,
    );
  }

  @override
  List<Object> get props => [status, historyArray];
}
