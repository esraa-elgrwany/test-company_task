import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/core/api/api-manager.dart';
import 'package:task/core/cache/shared_preferences.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/core/helper/company_manager/company_manager.dart';
import 'package:task/features/code/data/data_sources/remote/remote_ds.dart';
import 'package:task/features/code/data/data_sources/remote/remote_ds_impl.dart';
import 'package:task/features/code/data/repositories/code_repo_impl.dart';
import 'package:task/features/code/domain/entities/company_code_entity.dart';
import 'package:task/features/code/domain/repositories/code_repo.dart';
import 'package:task/features/code/domain/use_cases/code_usecases.dart';

part 'company_code_state.dart';

class CompanyCodeCubit extends Cubit<CompanyCodeState> {
  CompanyCodeCubit() : super(CompanyCodeInitial());

  static CompanyCodeCubit get(context) => BlocProvider.of(context);

  TextEditingController codeController=TextEditingController();
  var formKey = GlobalKey<FormState>();


  Future<void> sendCode() async {
    if (formKey.currentState?.validate() == true) {
      emit(SendCodeLoading());
      ApiManager apiManager = ApiManager();
      RemoteDs remoteDs = RemoteDsImpl(apiManager);
      CodeRepo codeRepo = CodeRepoImpl(remoteDs);
      CodeUseCase codeUseCase = CodeUseCase(codeRepo);
      var response = await codeUseCase.call(code: codeController.text);
      response.fold(
            (l) => emit(SendCodeFailure(l)),
            (r) {
          emit(SendCodeSuccess(r));
           print(CompanyManager().company);
          print("send code cubit+++++ ${r.data}");
        },
      );
    }
  }
}
