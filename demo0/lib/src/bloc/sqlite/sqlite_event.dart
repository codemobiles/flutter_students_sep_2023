part of 'sqlite_bloc.dart';

abstract class SqliteEvent {
  const SqliteEvent();
}

class SqliteEventInsert extends SqliteEvent {
  final SqliteModel payload;

  SqliteEventInsert(this.payload);
}

class SqliteEventQuery extends SqliteEvent {
  SqliteEventQuery();
}
