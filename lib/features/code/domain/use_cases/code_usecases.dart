import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/code/domain/entities/company_code_entity.dart';
import 'package:task/features/code/domain/repositories/code_repo.dart';

class CodeUseCase {
  CodeRepo codeRepo;

  CodeUseCase(this.codeRepo);

  Future<Either<Failures,CompanyCodeEntity>> call({required String code}) {
    return codeRepo.sendCode(code: code);
  }
}