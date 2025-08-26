import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/domain/entities/vacation_entity.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';
import 'package:task/features/home/presentation/pages/home_screen.dart';
import 'package:task/features/home/presentation/widgets/add_button.dart';
import 'package:task/features/home/presentation/widgets/date_picker_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:task/features/home/presentation/widgets/text_form_item.dart';
import 'package:task/features/login/presentation/widgets/failure_dialog.dart';
import 'package:task/features/login/presentation/widgets/loading_widget.dart';


class AddHolidayScreen extends StatefulWidget {
  const AddHolidayScreen({super.key});

  @override
  State<AddHolidayScreen> createState() => _AddHolidayScreenState();
}

class _AddHolidayScreenState extends State<AddHolidayScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedType;
  String? selectedStatusId;
 VacationEntityData? statusItem;
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  File? pickedFile;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: kIsWeb ? FileType.custom : FileType.any,
        allowedExtensions: kIsWeb ? ['jpg', 'png', 'pdf', 'doc'] : null,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          pickedFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      debugPrint("File picker error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeCubit()..getAgazaTypes(),
  child:BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    bool isLoading = state is AddAgazaLoading;
    return Stack(
    children: [
      Scaffold(
          appBar: AppBar(title:Text("Add Holiday")),
          body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Holiday type",style: Theme.of(context).textTheme.bodyMedium,),
                          SizedBox(height: 16.h),
                           Container(
                             padding: const EdgeInsets.symmetric(
                                 horizontal: 16),
                             decoration: BoxDecoration(
                               border: Border.all(
                                 color: Colors.grey
                               ),
                               borderRadius: BorderRadius.circular(16),
                             ),
                             child: BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                final leaveTypes =
                                    HomeCubit.get(context).vacationTypes;
                                return DropdownButtonFormField<VacationEntityData>(
                                  value:statusItem,
                                  hint: Text(
                                   "Holiday type",
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey
                                    )
                                  ),
                                  style: Theme.of(context).textTheme.bodySmall,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  dropdownColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  items: leaveTypes.map((type) {
                                    return DropdownMenuItem<VacationEntityData>(
                                      value: type,
                                      child: Text(type.vacationName?? ""),
                                    );
                                  }).toList(),
                                  validator: (value) => value == null
                                      ? 'Please select holiday type'
                                      : null,
                                  onChanged: (value) => setState(() {
                                    statusItem = value;
                                    selectedStatusId = value?.vacationId ?? "";
                                  }),
                                );
                              },
                                               ),
                           ),
                          SizedBox(height: 24.h),
                          Text("From date",style: Theme.of(context).textTheme.bodyMedium,),
                          SizedBox(height: 16.h),
                          DatePickerField(
                            label: "From Date",
                            controller: fromDateController,
                          ),
                          SizedBox(height: 24.h),
                          Text("To date",style: Theme.of(context).textTheme.bodyMedium,),
                          SizedBox(height: 16.h),
                          DatePickerField(
                            label: "To Date",
                            controller: toDateController,
                            onDateSelected: (date) {
                              if (fromDateController.text.isNotEmpty) {
                                final from =
                                DateTime.parse(fromDateController.text);
                                if (date.isBefore(from)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "End date must be after start date")),
                                  );
                                  toDateController.clear();
                                }
                              }
                            },
                          ),
                           SizedBox(height: 24.h),
                         TextFormItem(label:"reason",controller: reasonController, hint:"reason"),
                           SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  pickedFile != null
                                      ? pickedFile!.path.split('/').last
                                      : "No file selected",
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.attach_file),
                                onPressed: _pickFile,
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          BlocListener<HomeCubit,HomeState>(
    listener: (context, state) {
      if (state is AddAgazaFailure) {
        showDialog(
            context: context,
            builder: (context) => FailureDialog(msg: state.failure.errorMsg)
        );
      } else if (state is AddAgazaSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                "Agaza Added successfully",
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
        Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(),));
      }
    },
  
  child: AddButton(
                            text:"Submit",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (selectedStatusId == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Select holiday type")),
                                  );
                                  return;
                                }
                                HomeCubit.get(context).addAgaza(
                                  statusId: selectedStatusId??"0",
                                  fromDate: fromDateController.text,
                                  toDate: toDateController.text,
                                  reason: reasonController.text.isNotEmpty
                                      ? reasonController.text
                                      : null,
                                  file: pickedFile,
                                );
                              }
                            },
                          ),
),
                        ],
                      ),
                    ),
                  ),
                )
    )
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


