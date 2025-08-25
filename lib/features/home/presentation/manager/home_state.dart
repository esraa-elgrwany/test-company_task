part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
class AddSignLoading extends HomeState {}
//add signature
class AddSignSuccess extends HomeState{
  LoginEntity model;
  AddSignSuccess(this.model);
}

class AddSignFailure extends HomeState{
  String msg;
  AddSignFailure(this.msg);
}

class SignatureUpdated extends HomeState {
  final File signatureFile;
  SignatureUpdated(this.signatureFile);
}
// get agaza types

class AgazaTypesLoading extends HomeState {}
class AgazaTypesSuccess extends HomeState{
  VacationEntity model;
  AgazaTypesSuccess(this.model);
}

class AgazaTypesFailure extends HomeState{
  Failures failure;
  AgazaTypesFailure(this.failure);
}

// get agaza list
class AgazaListLoading extends HomeState {}
class AgazaListSuccess extends HomeState{
  GetHolidayEntity model;
  AgazaListSuccess(this.model);
}

class AgazaListFailure extends HomeState{
  Failures failure;
  AgazaListFailure(this.failure);
}
//agaza status color
class StatusChanged extends HomeState {
  final String selectedStatus;
  StatusChanged(this.selectedStatus);
}
// add agaza
class AddAgazaLoading extends HomeState {}
class AddAgazaSuccess extends HomeState{
  AddAgazaEntity model;
  AddAgazaSuccess(this.model);
}

class AddAgazaFailure extends HomeState{
  Failures failure;
  AddAgazaFailure(this.failure);
}