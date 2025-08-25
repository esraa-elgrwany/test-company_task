import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/code/domain/entities/company_code_entity.dart';

abstract  class CodeRepo{
  Future<Either<Failures,CompanyCodeEntity>> sendCode({required String code});
}