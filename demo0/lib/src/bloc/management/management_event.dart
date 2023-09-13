part of 'management_bloc.dart';

abstract class ManagementEvent {
  const ManagementEvent();
}

class ManagementEventSubmit extends ManagementEvent {
  final Product? product;
  final File? image;
  final bool? isEditMode;
  final GlobalKey<FormState>? form;

  const ManagementEventSubmit({
    this.product,
    this.image,
    this.isEditMode,
    this.form,
  });
}

class ManagementEventDelete extends ManagementEvent {
  final int productId;
  const ManagementEventDelete(this.productId);
}
