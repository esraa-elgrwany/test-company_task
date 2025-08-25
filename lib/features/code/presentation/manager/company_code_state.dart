part of 'company_code_cubit.dart';

@immutable
abstract class CompanyCodeState {}

class CompanyCodeInitial extends CompanyCodeState {}

class SendCodeLoading extends CompanyCodeState {}

class SendCodeSuccess extends CompanyCodeState {
  CompanyCodeEntity model;
  SendCodeSuccess(this.model);
}

class SendCodeFailure extends CompanyCodeState{
  Failures failures;
  SendCodeFailure(this.failures);
}