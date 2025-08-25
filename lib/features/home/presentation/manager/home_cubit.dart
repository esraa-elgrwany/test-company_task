import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/core/helper/user_manager/user_manager.dart';
import 'package:task/features/home/data/data_sources/remote/home_remote_ds.dart';
import 'package:task/features/home/data/data_sources/remote/home_remote_ds_impl.dart';
import 'package:task/features/home/data/repositories/home_repo_impl.dart';
import 'package:task/features/home/domain/entities/add_agaza_entity.dart';
import 'package:task/features/home/domain/entities/get_holiday_entity.dart';
import 'package:task/features/home/domain/entities/vacation_entity.dart';
import 'package:task/features/home/domain/repositories/home_repo.dart';
import 'package:task/features/home/domain/use_cases/add_agaza_use_case.dart';
import 'package:task/features/home/domain/use_cases/add_signature_use_case.dart';
import 'package:task/features/home/domain/use_cases/get_agaza_list_use_case.dart';
import 'package:task/features/home/domain/use_cases/get_agaza_types_use_case.dart';
import '../../../../core/api/api-manager.dart';
import '../../../login/domain/entities/login_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final user = UserManager().user!;
 String? uploadedSignature;
  List<VacationEntityData> vacationTypes = [];
  List<HolidayEntityData> agazaList = [];
  File? signatureFile;
  String selectedStatus = "gari";
  final List<String> statusList = const ["gari","wared", "accepted", "refused"];

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> addSignature() async {
    if (signatureFile == null) {
      emit(AddSignFailure("No signature file selected"));
      return;
    }

    emit(AddSignLoading());
    ApiManager apiManager = ApiManager();
    HomeRemoteDs remoteDs = HomeRemoteDsImpl(apiManager);
    HomeRepo homeRepo = HomeRepoImpl(remoteDs);
    AddSignatureUseCase addSignatureUseCase = AddSignatureUseCase(homeRepo);

    var response = await addSignatureUseCase.call(
      empId: user.empId ?? "0",
      signatureFile: signatureFile!,
    );

    response.fold(
          (l) => emit(AddSignFailure(l.errorMsg)),
          (r) {
        emit(AddSignSuccess(r));
         uploadedSignature = r.data?.empSignature??"";
        emit(SignatureUpdated(signatureFile!));
        print("Add Signature cubit+++++ ${r.data}");
      },
    );
  }

  getAgazaTypes() async {
    emit(AgazaTypesLoading());
    ApiManager apiManager = ApiManager();
    HomeRemoteDs remoteDs = HomeRemoteDsImpl(apiManager);
    HomeRepo homeRepo = HomeRepoImpl(remoteDs);
    GetAgazaTypesUseCase useCase = GetAgazaTypesUseCase(homeRepo);
    var response = await useCase.call();
    response.fold((l) {
      emit(AgazaTypesFailure(l));
    }, (r) {
      vacationTypes = r.data;
      print("Agaza Types cubit+++++ ${vacationTypes}");
      emit(AgazaTypesSuccess(r));
    });
  }

  getAgazaList() async {
    emit(AgazaListLoading());
    ApiManager apiManager = ApiManager();
    HomeRemoteDs remoteDs = HomeRemoteDsImpl(apiManager);
    HomeRepo homeRepo = HomeRepoImpl(remoteDs);
    GetAgazaListUseCase useCase = GetAgazaListUseCase(homeRepo);
    var response = await useCase.call(status: selectedStatus);
    response.fold((l) {
      emit(AgazaListFailure(l));
    }, (r) {
      agazaList = r.holidays;
      print("Agaza Types cubit+++++ ${agazaList}");
      emit(AgazaListSuccess(r));
    });
  }

  void changeStatus(String status) {
    selectedStatus = status;
    emit(StatusChanged(status));
    getAgazaList();
  }

  Future<void> addAgaza({
    required String statusId,
    required String fromDate,
    required String toDate,
    String? reason,
    File? file,
  }) async {

    emit(AddAgazaLoading());
    ApiManager apiManager = ApiManager();
    HomeRemoteDs remoteDs = HomeRemoteDsImpl(apiManager);
    HomeRepo homeRepo = HomeRepoImpl(remoteDs);
    AddAgazaUseCase addAgazaUseCase = AddAgazaUseCase(homeRepo);

    var response = await addAgazaUseCase.call(
     statusId:statusId ,
      fromDate:fromDate ,
      toDate: toDate,
      reason:reason ,
      file: file,
    );
    response.fold(
          (l) => emit(AddAgazaFailure(l)),
          (r) {
        emit(AddAgazaSuccess(r));
        print("Add Agaza cubit+++++ ${r.data}");
      },
    );
  }


}

