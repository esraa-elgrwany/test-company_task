import 'package:dartz/dartz.dart';
import 'package:task/features/login/domain/repositories/login_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/login_entity.dart';

class LoginUseCase {
  LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  Future<Either<Failures,LoginEntity>> call({required String phone,required String password}) {
    return loginRepo.login(phone: phone, password: password);
  }
}