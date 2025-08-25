import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/utils/app_strings.dart';
import 'package:task/features/code/presentation/widgets/text_form_widget.dart';
import 'package:task/features/home/presentation/pages/home_screen.dart';
import 'package:task/features/login/presentation/manager/login_cubit.dart';
import 'package:task/features/login/presentation/widgets/custom_button.dart';
import 'package:task/features/login/presentation/widgets/failure_dialog.dart';
import 'package:task/features/login/presentation/widgets/header.dart';
import 'package:task/features/login/presentation/widgets/loading_widget.dart';
import 'package:task/features/login/presentation/widgets/password_text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          bool isLoading = state is LoginLoading;
          return Stack(
            children: [
              Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Header(),
                          SizedBox(height: 24.h),
                          Form(
                            key: LoginCubit.get(context).formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.phone,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextFormWidget(
                                    controller: LoginCubit.get(
                                      context,
                                    ).phoneController,
                                    hint: AppStrings.phone,
                                    icon: Icons.phone,
                                    validateTxt: AppStrings.phoneValid,
                                  ),
                                  SizedBox(height: 24.h),
                                  Text(
                                    AppStrings.password,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  PasswordTextForm(
                                    controller: LoginCubit.get(
                                      context,
                                    ).passwordController,
                                  ),
                                  SizedBox(height: 40.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BlocListener<LoginCubit, LoginState>(
                                        listener: (context, state) {
                                          if (state is LoginFailure) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => FailureDialog(msg: state.failures.errorMsg)
                                            );
                                          } else if (state is LoginSuccess) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Center(
                                                  child: Text(
                                                    "Login successfully",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ),
                                                backgroundColor: Colors.green,
                                                duration: Duration(seconds: 5),
                                                behavior: SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(24),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(24),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 12,
                                                  horizontal: 4,
                                                ),
                                              ),
                                            );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => HomeScreen(),
                                              ),
                                            );
                                          }
                                        },
                                        child: InkWell(
                                          onTap: () {
                                            LoginCubit.get(context).login();
                                          },
                                          child: CustomButton(
                                            txt: AppStrings.login,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading)
               LoadingWidget()
            ],
          );
        },
      ),
    );
  }
}
