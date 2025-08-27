import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task/core/api/api-manager.dart';
import 'package:task/core/api/status_code_handler.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/core/helper/company_manager/company_manager.dart';
import 'package:task/core/utils/constants.dart';
import 'package:task/features/code/data/data_sources/remote/remote_ds.dart';
import 'package:task/features/code/data/models/company_code_model.dart';

class RemoteDsImpl implements RemoteDs {
  final ApiManager apiManager;

  RemoteDsImpl(this.apiManager);

  Future<Either<Failures, CompanyCodeModel>> sendCode({required String code}) async {
    try {
      final dio = Dio();
      final formData = FormData.fromMap({"code": code});

      final response = await dio.post(
        Constants.companyCodeUrl,
        data: formData,
        options: Options(
          headers: {
            "Accept": "*/*",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      debugPrint('[RemoteDs] status=${response.statusCode} data=${response.data}');

      if (response.statusCode == 200) {
        CompanyCodeModel model = CompanyCodeModel.fromJson(response.data);
        if (model.status == 200) {
          final companyData = model.data as CompanyDataModel;
          if (companyData != null) {
            await CompanyManager().saveCompany(companyData);
            CompanyManager().company;
          }

          return Right(model);
        } else {
          return Left(ServerFailure(model.message?.toString() ?? "Unknown error"));
        }
      }

      return Left(StatusCodeHandler.handleStatusCode(response.statusCode, response.data));
    } on DioException catch (e, st) {
      debugPrint('[RemoteDs][DioException] $e\n$st');
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e, st) {
      debugPrint('[RemoteDs][Unknown] $e\n$st');
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }
}
