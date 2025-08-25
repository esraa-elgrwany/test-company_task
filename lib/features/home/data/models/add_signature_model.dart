import 'package:task/features/home/domain/entities/add_signature_entity.dart';

import '../../domain/entities/add_signature_entity.dart';

class AddSignatureModel extends AddSignatureEntity {
  final int? status;
  final String? message;
  final AddSignatureModelData? data;

  AddSignatureModel({
    this.status,
    this.message,
    this.data,
  }) : super(
    status: status,
    message: message,
    data: data,
  );

  factory AddSignatureModel.fromJson(Map<String, dynamic> json) {
    return AddSignatureModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? AddSignatureModelData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class AddSignatureModelData extends AddSignatureEntityData {
  final String? userId;
  final String? empId;
  final String? empCode;
  final String? cardNum;
  final String? employee;
  final String? edaraName;
  final String? qsmName;
  final String? personalPhoto;
  final String? usersSignatures;
  final String? mosmaWazefyName;
  final String? phoneNumber;
  final String? empImg;
  final String? empSignature;

  AddSignatureModelData({
    this.userId,
    this.empId,
    this.empCode,
    this.cardNum,
    this.employee,
    this.edaraName,
    this.qsmName,
    this.personalPhoto,
    this.usersSignatures,
    this.mosmaWazefyName,
    this.phoneNumber,
    this.empImg,
    this.empSignature,
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

  factory AddSignatureModelData.fromJson(Map<String, dynamic> json) {
    return AddSignatureModelData(
      userId: json['user_id'],
      empId: json['emp_id'],
      empCode: json['emp_code'],
      cardNum: json['card_num'],
      employee: json['employee'],
      edaraName: json['edara_name'],
      qsmName: json['qsm_name'],
      personalPhoto: json['personal_photo'],
      usersSignatures: json['users_signatures'],
      mosmaWazefyName: json['mosma_wazefy_name'],
      phoneNumber: json['phone_number'],
      empImg: json['emp_img'],
      empSignature: json['emp_signature'],
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
