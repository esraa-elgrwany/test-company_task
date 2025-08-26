import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/home/domain/entities/edit_agaza_entity.dart';
import 'package:task/features/home/domain/repositories/home_repo.dart';

class EditAgazaUseCase {
  HomeRepo homeRepo;

  EditAgazaUseCase(this.homeRepo);

  Future<Either<Failures,EditAgazaEntity>> call({
    required String id,
    required String statusId,
    required String fromDate,
    required String toDate,
    String? reason,
  }) {
    return homeRepo.editAgaza(id:id, statusId:statusId,fromDate: fromDate, toDate: toDate,reason: reason);
  }
}