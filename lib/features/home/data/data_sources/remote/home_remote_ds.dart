import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/home/data/models/add_agaza_model.dart';
import 'package:task/features/home/data/models/delete_agaza_model.dart';
import 'package:task/features/home/data/models/edit_agaza_model.dart';
import 'package:task/features/home/data/models/employee_model.dart';
import 'package:task/features/home/data/models/get_holiday_model.dart';
import 'package:task/features/home/data/models/vacation_types_model.dart';
import 'package:task/features/login/data/models/login_model.dart';


abstract class HomeRemoteDs{
  Future<Either<Failures,LoginModel>> addSignature({required String empId,
    required File signatureFile});

  Future<Either<Failures,VacationModel>> getAgazaTypes();
  Future<Either<Failures,GetHolidayModel>> getAgazaList({required String status});

  Future<Either<Failures, AddAgazaModel>> addAgaza({
    required String statusId,
    required String fromDate,
    required String toDate,
    String? reason,
    File? file,
  });

  Future<Either<Failures, EditAgazaModel>> editAgaza({
    required String id,
    required String statusId,
    required String fromDate,
    required String toDate,
    String? reason,
  });
  Future<Either<Failures, DeleteAgazaModel>> deleteAgaza({
  required String id,});
  Future<Either<Failures,EmployeeModel>> getEmployee({String? search});
}