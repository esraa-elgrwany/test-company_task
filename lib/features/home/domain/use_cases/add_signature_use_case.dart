import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task/features/home/domain/repositories/home_repo.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';

import '../../../../core/errors/failures.dart';

class AddSignatureUseCase {
  HomeRepo homeRepo;

  AddSignatureUseCase(this.homeRepo);

  Future<Either<Failures, LoginEntity>> call({
    required String empId,
    required File signatureFile,
  }) {
    return homeRepo.addSignature(empId: empId, signatureFile: signatureFile);
  }
}
