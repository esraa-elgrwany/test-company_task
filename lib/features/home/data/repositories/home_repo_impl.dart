import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task/features/home/data/data_sources/remote/home_remote_ds.dart';
import 'package:task/features/home/data/models/add_agaza_model.dart';
import 'package:task/features/home/data/models/delete_agaza_model.dart';
import 'package:task/features/home/data/models/get_holiday_model.dart';
import 'package:task/features/home/data/models/vacation_types_model.dart';
import 'package:task/features/home/domain/entities/edit_agaza_entity.dart';
import 'package:task/features/home/domain/entities/employee_entity.dart';
import 'package:task/features/login/data/models/login_model.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRemoteDs remoteDs;

  HomeRepoImpl(this.remoteDs);

  @override
  Future<Either<Failures, LoginModel>> addSignature({
    required String empId,
    required File signatureFile,
  })async {
    var res = await remoteDs.addSignature(empId: empId,signatureFile: signatureFile);
    return res;
  }

  @override
  Future<Either<Failures, VacationModel>> getAgazaType()async{
    var res = await remoteDs.getAgazaTypes();
    return res;
  }

  @override
  Future<Either<Failures, GetHolidayModel>> getAgazaList({required String status}) async{
    var res = await remoteDs.getAgazaList(status: status);
    return res;
  }

  @override
  Future<Either<Failures, AddAgazaModel>> addAgaza({required String statusId, required String fromDate, required String toDate,
    String? reason, File? file}) async{
    var res = await remoteDs.addAgaza(statusId: statusId, fromDate: fromDate, toDate: toDate,reason: reason,file: file);
    return res;
  }

  @override
  Future<Either<Failures, DeleteAgazaModel>> deleteAgaza({required String id}) async{
    var res = await remoteDs.deleteAgaza(id: id);
    return res;
  }

  @override
  Future<Either<Failures, EditAgazaEntity>> editAgaza({required String id, required String statusId, required String fromDate,
    required String toDate, String? reason}) async{
    var res = await remoteDs.editAgaza(id:id,statusId: statusId, fromDate: fromDate, toDate: toDate,reason: reason);
    return res;
  }

  @override
  Future<Either<Failures, EmployeeEntity>> getEmployee({String? search}) async{
    var res = await remoteDs.getEmployee(search: search);
    return res;
  }
}