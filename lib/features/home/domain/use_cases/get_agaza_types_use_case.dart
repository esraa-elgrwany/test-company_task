import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/home/domain/entities/vacation_entity.dart';
import 'package:task/features/home/domain/repositories/home_repo.dart';

class GetAgazaTypesUseCase{
  HomeRepo homeRepo;

  GetAgazaTypesUseCase(this.homeRepo);

  Future<Either<Failures, VacationEntity>> call() {
    return homeRepo.getAgazaType();
  }
}
