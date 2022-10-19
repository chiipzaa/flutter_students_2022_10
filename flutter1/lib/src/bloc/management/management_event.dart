part of 'management_bloc.dart';

class ManagementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ManagementEvent_Submit extends ManagementEvent {
  final Product? product;
  final File? image;
  final bool? isEditMode;
  final GlobalKey<FormState>? form;

  ManagementEvent_Submit({
    this.product,
    this.image,
    this.isEditMode,
    this.form,
  });
}
