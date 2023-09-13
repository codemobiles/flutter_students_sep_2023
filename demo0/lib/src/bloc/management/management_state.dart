part of 'management_bloc.dart';

sealed class ManagementState extends Equatable {
  const ManagementState();
  
  @override
  List<Object> get props => [];
}

final class ManagementInitial extends ManagementState {}
