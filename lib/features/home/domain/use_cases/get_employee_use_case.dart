import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/home/domain/entities/employee_entity.dart';
import 'package:task/features/home/domain/repositories/home_repo.dart';

class GetEmployeeUseCase{
  HomeRepo homeRepo;

  GetEmployeeUseCase(this.homeRepo);

  Future<Either<Failures, EmployeeEntity>> call({String? search}) {
    return homeRepo.getEmployee(search:search);
  }
}