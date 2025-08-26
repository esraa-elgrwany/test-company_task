import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/data/models/vacation_types_model.dart';
import 'package:task/features/home/domain/entities/get_holiday_entity.dart';
import 'package:task/features/home/domain/entities/vacation_entity.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';
import 'package:task/features/home/presentation/pages/home_screen.dart';
import 'package:task/features/home/presentation/widgets/add_button.dart';
import 'package:task/features/home/presentation/widgets/date_picker_field.dart';
import 'package:task/features/home/presentation/widgets/text_form_item.dart';
import 'package:task/features/login/presentation/widgets/failure_dialog.dart';
import 'package:task/features/login/presentation/widgets/loading_widget.dart';

class EditHolidayScreen extends StatefulWidget {
  final HolidayEntityData args;

  const EditHolidayScreen({super.key, required this.args});

  @override
  State<EditHolidayScreen> createState() => _EditHolidayScreenState();
}

class _EditHolidayScreenState extends State<EditHolidayScreen> {


  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).editFromDateController.text = widget.args.fromDate ?? "";
    HomeCubit.get(context).editToDateController.text = widget.args.toDate ?? "";
    HomeCubit.get(context).editReasonController.text = widget.args.reason ?? "";
    HomeCubit.get(context).editSelectedStatusId = widget.args.holidayTypeId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAgazaTypes(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          bool isLoading = state is EditAgazaLoading;
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(title: const Text("Edit Holiday")),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: HomeCubit.get(context).editFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Holiday type",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: BlocBuilder<HomeCubit, HomeState>(
                                builder: (context, state) {
                                  if (state is AgazaTypesLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.green,
                                      ),
                                    );
                                  } else if (state is AgazaTypesFailure) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            color: Colors.red,
                                            size: 50,
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            state.failure.errorMsg,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else if (state is AgazaTypesSuccess) {
                                    final leaveTypes = HomeCubit.get(
                                      context,
                                    ).vacationTypes;
                                    HomeCubit.get(context).editStatusItem = leaveTypes.firstWhere(
                                      (e) => e.vacationId == HomeCubit.get(context).editSelectedStatusId,
                                    );
                                    return DropdownButtonFormField<
                                      VacationEntityData
                                    >(
                                      value: HomeCubit.get(context).editStatusItem,
                                      hint: Text(
                                        "Holiday type",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                      isExpanded: true,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      dropdownColor: Theme.of(
                                        context,
                                      ).colorScheme.onBackground,
                                      items: leaveTypes.map((type) {
                                        return DropdownMenuItem<
                                          VacationEntityData
                                        >(
                                          value: type,
                                          child: Text(type.vacationName ?? ""),
                                        );
                                      }).toList(),
                                      validator: (value) => value == null
                                          ? 'Please select holiday type'
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          HomeCubit.get(context).editStatusItem = value;
                                          HomeCubit.get(context).editSelectedStatusId =
                                              value?.vacationId ?? "";
                                        });
                                      },
                                    );
                                  }
                                  return SizedBox();
                                },
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              "From date",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(height: 16.h),
                            DatePickerField(
                              label: "From Date",
                              controller: HomeCubit.get(context).editFromDateController,
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              "To date",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(height: 16.h),
                            DatePickerField(
                              label: "To Date",
                              controller: HomeCubit.get(context).editToDateController,
                              onDateSelected: (date) {
                                if (HomeCubit.get(context).editFromDateController.text.isNotEmpty) {
                                  final from = DateTime.parse(
                                    HomeCubit.get(context).editFromDateController.text,
                                  );
                                  if (date.isBefore(from)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "End date must be after start date",
                                        ),
                                      ),
                                    );
                                    HomeCubit.get(context).editToDateController.clear();
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 24.h),
                            TextFormItem(
                              label: "Reason",
                              controller: HomeCubit.get(context).editReasonController,
                              hint: "Reason",
                            ),
                            SizedBox(height: 24.h),
                            BlocListener<HomeCubit, HomeState>(
                              listener: (context, state) {
                                if (state is EditAgazaFailure) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => FailureDialog(
                                      msg: state.failure.errorMsg,
                                    ),
                                  );
                                } else if (state is EditAgazaSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(
                                        child: Text(
                                          "Agaza Edited successfully",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
                                      duration: const Duration(seconds: 5),
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.all(24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 4,
                                      ),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                }
                              },
                              child: AddButton(
                                text: "Edit",
                                onPressed: () {
                                  if (HomeCubit.get(context).editFormKey.currentState!.validate()) {
                                    if (HomeCubit.get(context).editSelectedStatusId == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Select holiday type"),
                                        ),
                                      );
                                      return;
                                    }
                                    HomeCubit.get(context).editAgaza(
                                      id: widget.args.id,
                                      statusId: HomeCubit.get(context).editSelectedStatusId ?? "0",
                                      fromDate: HomeCubit.get(context).editFromDateController.text,
                                      toDate: HomeCubit.get(context).editToDateController.text,
                                      reason: HomeCubit.get(context).editReasonController.text.isNotEmpty
                                          ? HomeCubit.get(context).editReasonController.text
                                          : null,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading) LoadingWidget(),
            ],
          );
        },
      ),
    );
  }
}
