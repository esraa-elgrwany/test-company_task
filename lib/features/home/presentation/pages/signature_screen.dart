import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:task/features/home/presentation/pages/home_screen.dart';
import 'package:task/features/login/presentation/widgets/failure_dialog.dart';
import 'package:task/features/login/presentation/widgets/loading_widget.dart';

import '../manager/home_cubit.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveSignature(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please draw your signature")),
      );
      return;
    }

    final export = await _controller.toPngBytes();
    if (export != null) {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(export);
      final cubit = HomeCubit.get(context);
      cubit.signatureFile = file;
      cubit.addSignature();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddSignFailure) {
            showDialog(
              context: context,
              builder: (_) => FailureDialog(msg: state.msg),
            );
          } else if (state is AddSignSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    "Signature added successfully",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => HomeScreen(),));
          }
        },
        builder: (context, state) {
          final isLoading = state is AddSignLoading;

          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(title: const Text("Add Signature")),
                body: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        child: Signature(
                          controller: _controller,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _saveSignature(context),
                              child: Text(
                                "Save",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _controller.clear(),
                              child: Text(
                                "Clear",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading) const LoadingWidget(),
            ],
          );
        },
      ),
    );
  }
}


