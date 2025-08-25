import 'package:dartz/dartz.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';
import '../../../../core/errors/failures.dart';

abstract  class LoginRepo{
  Future<Either<Failures,LoginEntity>> login({required String phone,required String password});
}