import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/code/data/models/company_code_model.dart';

abstract class RemoteDs{
  Future<Either<Failures,CompanyCodeModel>> sendCode({required String code});
}