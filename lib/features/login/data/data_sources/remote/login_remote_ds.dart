import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/login/data/models/login_model.dart';

abstract class LoginRemoteDs{
  Future<Either<Failures,LoginModel>> login({required String phone,required String password});
}