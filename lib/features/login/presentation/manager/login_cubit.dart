import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/core/api/api-manager.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/login/data/data_sources/remote/login_remote_ds.dart';
import 'package:task/features/login/data/data_sources/remote/login_remote_ds_impl.dart';
import 'package:task/features/login/data/repositories/login_repo_impl.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';
import 'package:task/features/login/domain/repositories/login_repo.dart';
import 'package:task/features/login/domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      emit(LoginLoading());
      ApiManager apiManager = ApiManager();
      LoginRemoteDs remoteDs = LoginRemoteDsImpl(apiManager);
      LoginRepo loginRepo = LoginRepoImpl(remoteDs);
      LoginUseCase loginUseCase = LoginUseCase(loginRepo);
      var response = await loginUseCase.call(
          phone: phoneController.text, password: passwordController.text);
      response.fold(
            (l) => emit(LoginFailure(l)),
            (r) {
          emit(LoginSuccess(r));
          print("Login cubit+++++ ${r.data}");
        },
      );
    }
  }
}
