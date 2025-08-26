import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:task/features/home/domain/entities/add_agaza_entity.dart';
import 'package:task/features/home/domain/entities/get_holiday_entity.dart';
import 'package:task/features/home/domain/entities/vacation_entity.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';
import '../../../../core/errors/failures.dart';
import 'package:task/features/home/domain/entities/delete_agaza_entity.dart';
import 'package:task/features/home/domain/entities/edit_agaza_entity.dart';
import 'package:task/features/home/domain/entities/employee_entity.dart';

abstract class HomeRepo {
  Future<Either<Failures, LoginEntity>> addSignature({
    required String empId,
    required File signatureFile,
  });
  Future<Either<Failures,VacationEntity>> getAgazaType();

  Future<Either<Failures,GetHolidayEntity>> getAgazaList({required String status});
  Future<Either<Failures, AddAgazaEntity>> addAgaza({
    required String statusId,
    required String fromDate,
    required String toDate,
    String? reason,
    File? file,
  });
  Future<Either<Failures, EditAgazaEntity>> editAgaza({
    required String id,
    required String statusId,
    required String fromDate,
    required String toDate,
    String? reason,
  });

  Future<Either<Failures, DeleteAgazaEntity>> deleteAgaza({
    required String id,
  });
  Future<Either<Failures, EmployeeEntity>> getEmployee({
    String? search,
  });
}
