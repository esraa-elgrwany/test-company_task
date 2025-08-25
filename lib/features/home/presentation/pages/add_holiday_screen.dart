import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/domain/entities/vacation_entity.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';
import 'package:task/features/home/presentation/widgets/add_button.dart';
import 'package:task/features/home/presentation/widgets/date_picker_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:task/features/home/presentation/widgets/text_form_item.dart';


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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeCubit()..getAgazaTypes(),
  child: Scaffold(
      appBar: AppBar(title: const Text("Add Holiday")),
      body:  BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddAgazaSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.model.message ?? "Success")),
            );
            Navigator.pop(context, true);
          } else if (state is AddAgazaFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure.errorMsg ?? "Failed")),
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [

                   BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      final leaveTypes =
                          HomeCubit.get(context).vacationTypes;
                      return DropdownButtonFormField<VacationEntityData>(
                        value:statusItem,
                        hint: Text(
                         "Holiday type",
                          style: Theme.of(context).textTheme.bodySmall
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

                  SizedBox(height: 16.h),
                  DatePickerField(
                    label: "From Date",
                    controller: fromDateController,
                  ),

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

                   SizedBox(height: 16.h),
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
                  AddButton(
                    text: state is AddAgazaLoading
                        ? "Submitting..."
                        : "Submit",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedStatusId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Select holiday type")),
                          );
                          return;
                        }
                        cubit.addAgaza(
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
                ],
              ),
            ),
          );
        },
      ),

    ),
);
  }
}


