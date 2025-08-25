import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:task/core/api/api-manager.dart';
import 'package:task/core/api/status_code_handler.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/core/helper/user_manager/user_manager.dart';
import 'package:task/features/home/data/data_sources/remote/home_remote_ds.dart';
import 'package:task/features/home/data/models/add_agaza_model.dart';
import 'package:task/features/home/data/models/delete_agaza_model.dart';
import 'package:task/features/home/data/models/edit_agaza_model.dart';
import 'package:task/features/home/data/models/employee_model.dart';
import 'package:task/features/home/data/models/get_holiday_model.dart';
import 'package:task/features/home/data/models/vacation_types_model.dart';
import 'package:task/features/login/data/models/login_model.dart';

import '../../../../../core/api/end_points.dart';

class HomeRemoteDsImpl implements HomeRemoteDs {
  final ApiManager apiManager;

  HomeRemoteDsImpl(this.apiManager);

  @override
  Future<Either<Failures, LoginModel>> addSignature({required String empId, required File signatureFile}) async{
    try {
      final formData = FormData.fromMap({
        "emp_id": empId,
        "m_image": await MultipartFile.fromFile(signatureFile.path),
      });

      final response = await apiManager.postData(EndPoints.addSignature, body: formData);

      debugPrint('[addSignature] status=${response.statusCode} data=${response.data}');
      if (response.statusCode == 200) {
        LoginModel model = LoginModel.fromJson(response.data);
        if (model.status == 200) {
          final updatedUserData = model.data as UserDataModel?;
          if (updatedUserData != null) {
            await UserManager().saveUser(updatedUserData);
          }
          return Right(model);
        } else {
          return Left(ServerFailure(model.message?.toString() ?? "Unknown error"));
        }
      }
      return Left(StatusCodeHandler.handleStatusCode(response.statusCode, response.data));
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, VacationModel>> getAgazaTypes() async{
    try {
      final response = await apiManager.postData(EndPoints.getAgazaType);

      debugPrint('[get agaza types] status=${response.statusCode} data=${response.data}');
      if (response.statusCode == 200) {
        VacationModel model = VacationModel.fromJson(response.data);
        if (model.status == 200) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message?.toString() ?? "Unknown error"));
        }
      }
      return Left(StatusCodeHandler.handleStatusCode(response.statusCode, response.data));
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, GetHolidayModel>> getAgazaList({required String status}) async{
    try {
      final formData = FormData.fromMap({
        "emp_id": UserManager().user?.empId??"0",
        "status":status,
      });
      final response = await apiManager.postData(EndPoints.getAgazaList,body:formData );

      debugPrint('[get agaza List] status=${response.statusCode} data=${response.data}');
      if (response.statusCode == 200) {
        GetHolidayModel model = GetHolidayModel.fromJson(response.data);
        if (model.status == 200) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message?.toString() ?? "Unknown error"));
        }
      }
      return Left(StatusCodeHandler.handleStatusCode(response.statusCode, response.data));
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, AddAgazaModel>> addAgaza({
    required String statusId,
    required String fromDate,
    required String toDate,
    String? reason,
    File? file,
  }) async {
    try {
      final formData = FormData.fromMap({
        "emp_id": UserManager().user?.empId??"0",
        "no3_agaza_id": statusId,
        "from_date": fromDate,
        "to_date": toDate,
        if (reason != null && reason.isNotEmpty) "reason": reason,
        if (file != null)
          "f_file": await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
      });

      final response = await apiManager.postData(
        EndPoints.addAgaza,
        body: formData,
      );

      debugPrint('[addAgaza] status=${response.statusCode} data=${response.data}');

      if (response.statusCode == 200) {
        AddAgazaModel model = AddAgazaModel.fromJson(response.data);

        if (model.status == 200) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? "Unknown error"));
        }
      }

      return Left(StatusCodeHandler.handleStatusCode(
        response.statusCode,
        response.data,
      ));
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, EmployeeModel>> getEmployee({String? search}) async{
    try {
      final formData = FormData.fromMap({
        "page": 1,
        "per_page": 100,
        "emp_id": UserManager().user?.empId??"0",
        if (search != null && search.isNotEmpty) "search_title": search,
      });

      final response = await apiManager.postData(EndPoints.getEmp, body: formData);

      debugPrint('[get employee] status=${response.statusCode} data=${response.data}');
      if (response.statusCode == 200) {
        EmployeeModel model = EmployeeModel.fromJson(response.data);
        if (model.status == 200) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message?.toString() ?? "Unknown error"));
        }
      }
      return Left(StatusCodeHandler.handleStatusCode(response.statusCode, response.data));
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override

  Future<Either<Failures, EditAgazaModel>> editAgaza({required String id, required String statusId, required String fromDate,
    required String toDate, String? reason}) async{
    try {
      final formData = FormData.fromMap({
        "agaza_id":id,
        "emp_id": UserManager().user?.empId??"0",
        "no3_agaza_id": statusId,
        "from_date": fromDate,
        "to_date": toDate,
        if (reason != null && reason.isNotEmpty) "reason": reason,
      });

      final response = await apiManager.postData(
        EndPoints.editAgaza,
        body: formData,
      );

      debugPrint('[EditAgaza] status=${response.statusCode} data=${response.data}');

      if (response.statusCode == 200) {
        EditAgazaModel model = EditAgazaModel.fromJson(response.data);

        if (model.status == 200) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? "Unknown error"));
        }
      }

      return Left(StatusCodeHandler.handleStatusCode(
        response.statusCode,
        response.data,
      ));
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, DeleteAgazaModel>> deleteAgaza({required String id})async {
    try {
      final formData = FormData.fromMap({
        "agaza_id":id,
      });

      final response = await apiManager.postData(
        EndPoints.deleteAgaza,
        body: formData,
      );

      debugPrint('[DeleteAgaza] status=${response.statusCode} data=${response.data}');

      if (response.statusCode == 200) {
        DeleteAgazaModel model = DeleteAgazaModel.fromJson(response.data);

        if (model.status == 200) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? "Unknown error"));
        }
      }

      return Left(StatusCodeHandler.handleStatusCode(
        response.statusCode,
        response.data,
      ));
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }
}