import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/home/domain/entities/delete_agaza_entity.dart';
import 'package:task/features/home/domain/repositories/home_repo.dart';

class DeleteAgazaUseCase {
  HomeRepo homeRepo;

  DeleteAgazaUseCase(this.homeRepo);

  Future<Either<Failures,DeleteAgazaEntity>> call({
    required String id,
  }) {
    return homeRepo.deleteAgaza(id:id);
  }
}