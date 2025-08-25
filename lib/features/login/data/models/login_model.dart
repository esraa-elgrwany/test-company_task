import 'package:task/features/login/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity{
  LoginModel({
    int? status,
    String? message,
    int? logoutOption,
    UserDataModel? data,
  }) : super(
    status: status,
    message: message,
    logoutOption: logoutOption,
    data: data,
  );

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      logoutOption: json['logout_option'] as int?,
      data: json['data'] != null ? UserDataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'logout_option': logoutOption,
      if (data != null) 'data': (data as UserDataModel).toJson(),
    };
  }
}

class UserDataModel extends UserDataEntity {
  UserDataModel({
    String? userId,
    String? empId,
    String? empCode,
    String? cardNum,
    String? employee,
    String? edaraName,
    String? qsmName,
    String? personalPhoto,
    String? usersSignatures,
    String? mosmaWazefyName,
    String? phoneNumber,
    String? empImg,
    String? empSignature,
  }) : super(
    userId: userId,
    empId: empId,
    empCode: empCode,
    cardNum: cardNum,
    employee: employee,
    edaraName: edaraName,
    qsmName: qsmName,
    personalPhoto: personalPhoto,
    usersSignatures: usersSignatures,
    mosmaWazefyName: mosmaWazefyName,
    phoneNumber: phoneNumber,
    empImg: empImg,
    empSignature: empSignature,
  );

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userId: json['user_id'] as String?,
      empId: json['emp_id'] as String?,
      empCode: json['emp_code'] as String?,
      cardNum: json['card_num'] as String?,
      employee: json['employee'] as String?,
      edaraName: json['edara_name'] as String?,
      qsmName: json['qsm_name'] as String?,
      personalPhoto: json['personal_photo'] as String?,
      usersSignatures: json['users_signatures'] as String?,
      mosmaWazefyName: json['mosma_wazefy_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      empImg: json['emp_img'] as String?,
      empSignature: json['emp_signature'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'emp_id': empId,
      'emp_code': empCode,
      'card_num': cardNum,
      'employee': employee,
      'edara_name': edaraName,
      'qsm_name': qsmName,
      'personal_photo': personalPhoto,
      'users_signatures': usersSignatures,
      'mosma_wazefy_name': mosmaWazefyName,
      'phone_number': phoneNumber,
      'emp_img': empImg,
      'emp_signature': empSignature,
    };
  }
}
