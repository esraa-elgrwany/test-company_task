import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/home/domain/entities/add_agaza_entity.dart';
import 'package:task/features/home/domain/repositories/home_repo.dart';

class AddAgazaUseCase {
  HomeRepo homeRepo;

  AddAgazaUseCase(this.homeRepo);

  Future<Either<Failures, AddAgazaEntity>> call({
    required String statusId,
    required String fromDate,
    required String toDate,
    String? reason,
    File? file,
  }) {
    return homeRepo.addAgaza(statusId: statusId, fromDate: fromDate, toDate: toDate,reason: reason,file: file);
  }
}