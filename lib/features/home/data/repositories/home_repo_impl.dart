import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task/features/home/data/data_sources/remote/home_remote_ds.dart';
import 'package:task/features/home/data/models/add_agaza_model.dart';
import 'package:task/features/home/domain/entities/add_agaza_entity.dart';
import 'package:task/features/home/domain/entities/get_holiday_entity.dart';
import 'package:task/features/home/domain/entities/vacation_entity.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRemoteDs remoteDs;

  HomeRepoImpl(this.remoteDs);

  @override
  Future<Either<Failures, LoginEntity>> addSignature({
    required String empId,
    required File signatureFile,
  })async {
    var res = await remoteDs.addSignature(empId: empId,signatureFile: signatureFile);
    return res;
  }

  @override
  Future<Either<Failures, VacationEntity>> getAgazaType()async{
    var res = await remoteDs.getAgazaTypes();
    return res;
  }

  @override
  Future<Either<Failures, GetHolidayEntity>> getAgazaList({required String status}) async{
    var res = await remoteDs.getAgazaList(status: status);
    return res;
  }

  @override
  Future<Either<Failures, AddAgazaEntity>> addAgaza({required String statusId, required String fromDate, required String toDate,
    String? reason, File? file}) async{
    var res = await remoteDs.addAgaza(statusId: statusId, fromDate: fromDate, toDate: toDate,reason: reason,file: file);
    return res;
  }
}