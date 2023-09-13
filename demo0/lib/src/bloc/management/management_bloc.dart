import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:demo0/src/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'management_event.dart';
part 'management_state.dart';

class ManagementBloc extends Bloc<ManagementEvent, ManagementState> {
  ManagementBloc() : super(const ManagementState()) {
    
    // Submit
    on<ManagementEventSubmit>((event, emit) {});

    // Delete
    on<ManagementEventDelete>((event, emit) {});
  }
}
