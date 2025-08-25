import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/code/data/data_sources/remote/remote_ds.dart';
import 'package:task/features/code/domain/entities/company_code_entity.dart';
import 'package:task/features/code/domain/repositories/code_repo.dart';

class CodeRepoImpl implements CodeRepo{
  RemoteDs remoteDs;
  CodeRepoImpl(this.remoteDs);
  @override
  Future<Either<Failures, CompanyCodeEntity>> sendCode({required String code}) async{
    var res= await remoteDs.sendCode(code: code);
    return res;
  }

}