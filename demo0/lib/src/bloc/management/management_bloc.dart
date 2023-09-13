import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'management_event.dart';
part 'management_state.dart';

class ManagementBloc extends Bloc<ManagementEvent, ManagementState> {
  ManagementBloc() : super(ManagementInitial()) {
    on<ManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
