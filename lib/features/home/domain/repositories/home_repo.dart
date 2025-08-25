import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:task/features/home/domain/entities/add_agaza_entity.dart';
import 'package:task/features/home/domain/entities/get_holiday_entity.dart';
import 'package:task/features/home/domain/entities/vacation_entity.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';
import '../../../../core/errors/failures.dart';

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
}
