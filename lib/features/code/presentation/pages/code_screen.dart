import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helper/company_manager/company_manager.dart';
import 'package:task/core/utils/app_strings.dart';
import 'package:task/features/code/presentation/manager/company_code_cubit.dart';
import 'package:task/features/code/presentation/widgets/button_widget.dart';
import 'package:task/features/code/presentation/widgets/text_form_widget.dart';
import 'package:task/features/login/presentation/pages/login_screen.dart';
import 'package:task/features/login/presentation/widgets/failure_dialog.dart';
import 'package:task/features/login/presentation/widgets/loading_widget.dart';
import 'package:task/features/theme/presentation/manager/theme_cubit.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyCodeCubit(),
      child: BlocBuilder<CompanyCodeCubit, CompanyCodeState>(
        builder: (context, state) {
          bool isLoading = state is SendCodeLoading;
          return Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: CompanyCodeCubit.get(context).formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.enterCode,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: 32.h),
                          TextFormWidget(
                            controller: CompanyCodeCubit.get(
                              context,
                            ).codeController,
                            hint: AppStrings.comCode,
                            icon: Icons.numbers,
                            validateTxt: AppStrings.codeValid,
                          ),
                          SizedBox(height: 32.h),
                          BlocListener<CompanyCodeCubit, CompanyCodeState>(
                            listener: (context, state) {
                              if (state is SendCodeFailure) {
                                showDialog(
                                  context: context,
                                  builder: (context) => FailureDialog(msg: state.failures.errorMsg)
                                );
                              } else if (state is SendCodeSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text(
                                        "Send Code successfully",
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
                                context.read<ThemeCubit>().updatePrimaryColor(
                                 CompanyManager().primaryColor
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              }
                            },
                            child: InkWell(
                              onTap: () {
                                CompanyCodeCubit.get(context).sendCode();
                              },
                              child: ButtonWidget(txt: AppStrings.cont),
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
