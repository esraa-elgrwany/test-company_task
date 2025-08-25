import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/home/domain/entities/get_holiday_entity.dart';
import 'package:task/features/home/domain/repositories/home_repo.dart';

class GetAgazaListUseCase{
  HomeRepo homeRepo;

  GetAgazaListUseCase(this.homeRepo);

  Future<Either<Failures, GetHolidayEntity>> call({required String status}) {
    return homeRepo.getAgazaList(status: status);
  }
}