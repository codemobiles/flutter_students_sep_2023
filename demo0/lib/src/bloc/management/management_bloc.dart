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
    on<ManagementEventSubmit>((event, emit) {
 final product = event.product!;
      final imageFile = event.image;
      final editMode = event.isEditMode!;
      final form = event.form!;

      emit(state.copyWith(status: SubmitStatus.submitting));
      hideKeyboard();
      form.currentState?.save();
      try {
        String result;
        if (editMode) {
          result =
              await NetworkService().editProduct(product, imageFile: imageFile);
        } else {
          logger.i("Add Product : $product");
          result =
              await NetworkService().addProduct(product, imageFile: imageFile);
        }
        Navigator.pop(navigatorState.currentContext!);
        emit(state.copyWith(status: SubmitStatus.success));

        CustomFlushbar.showSuccess(navigatorState.currentContext!,
            message: result);
      } catch (exception) {
        CustomFlushbar.showError(navigatorState.currentContext!,
            message: 'network fail');
        emit(state.copyWith(status: SubmitStatus.failed));
      }

    });

    // Delete
    on<ManagementEventDelete>((event, emit) {});
  }
}
