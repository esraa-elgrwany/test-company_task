import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:task/core/api/api-manager.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/core/helper/user_manager/user_manager.dart';
import 'package:task/features/login/data/data_sources/remote/login_remote_ds.dart';
import 'package:task/features/login/data/models/login_model.dart';

import '../../../../../core/api/status_code_handler.dart';

class LoginRemoteDsImpl implements LoginRemoteDs {
  final ApiManager apiManager;

  LoginRemoteDsImpl(this.apiManager);

  @override
  Future<Either<Failures, LoginModel>> login({required String phone, required String password}) async{
    try {
      final formData = FormData.fromMap({"phone":phone,"user_pass":password});

      final response = await apiManager.postData(EndPoints.login,body: formData);

      debugPrint('[login RemoteDs] status=${response.statusCode} data=${response.data}');

      if (response.statusCode == 200) {
        LoginModel model = LoginModel.fromJson(response.data);
        if (model.status == 200) {
          final userData = model.data as UserDataModel?;
          if (userData != null) {
            await UserManager().saveUser(userData);
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
}