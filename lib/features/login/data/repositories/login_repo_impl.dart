import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/login/data/data_sources/remote/login_remote_ds.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';
import 'package:task/features/login/domain/repositories/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  LoginRemoteDs remoteDs;

  LoginRepoImpl(this.remoteDs);

  @override
  Future<Either<Failures, LoginEntity>> login({
    required String phone,
    required String password,
  }) async {
    var res = await remoteDs.login(phone: phone, password: password);
    return res;
  }
}
