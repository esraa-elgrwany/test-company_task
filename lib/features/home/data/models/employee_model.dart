import 'package:task/features/home/domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity{
  final int? status;
  final String? message;
  final List<EmployeeModelData>? data;

  const EmployeeModel({
    this.status,
    this.message,
    this.data,
  }) : super(
    status: status,
    message: message,
    data: data,
  );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => EmployeeModelData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };

  EmployeeModel copyWith({
    int? status,
    String? message,
    List<EmployeeModelData>? data,
  }) {
    return EmployeeModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

class EmployeeModelData extends EmployeeEntityData {
  final String? empId;
  final String? userId;
  final String? cardNum;
  final String? empCode;
  final String? employee;
  final String? edaraName;
  final String? qsmName;
  final String? mosmaWazefyName;
  final String? phoneNumber;
  final String? personalPhoto;
  final String? empImg;

  const EmployeeModelData({
    this.empId,
    this.userId,
    this.cardNum,
    this.empCode,
    this.employee,
    this.edaraName,
    this.qsmName,
    this.mosmaWazefyName,
    this.phoneNumber,
    this.personalPhoto,
    this.empImg,
  }) : super(
    empId: empId,
    userId: userId,
    cardNum: cardNum,
    empCode: empCode,
    employee: employee,
    edaraName: edaraName,
    qsmName: qsmName,
    mosmaWazefyName: mosmaWazefyName,
    phoneNumber: phoneNumber,
    personalPhoto: personalPhoto,
    empImg: empImg,
  );

  factory EmployeeModelData.fromJson(Map<String, dynamic> json) {
    return EmployeeModelData(
      empId: json['emp_id'] as String?,
      userId: json['user_id'] as String?,
      cardNum: json['card_num'] as String?,
      empCode: json['emp_code'] as String?,
      employee: json['employee'] as String?,
      edaraName: json['edara_name'] as String?,
      qsmName: json['qsm_name'] as String?,
      mosmaWazefyName: json['mosma_wazefy_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      personalPhoto: json['personal_photo'] as String?,
      empImg: json['emp_img'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'emp_id': empId,
    'user_id': userId,
    'card_num': cardNum,
    'emp_code': empCode,
    'employee': employee,
    'edara_name': edaraName,
    'qsm_name': qsmName,
    'mosma_wazefy_name': mosmaWazefyName,
    'phone_number': phoneNumber,
    'personal_photo': personalPhoto,
    'emp_img': empImg,
  };

  EmployeeModelData copyWith({
    String? empId,
    String? userId,
    String? cardNum,
    String? empCode,
    String? employee,
    String? edaraName,
    String? qsmName,
    String? mosmaWazefyName,
    String? phoneNumber,
    String? personalPhoto,
    String? empImg,
  }) {
    return EmployeeModelData(
      empId: empId ?? this.empId,
      userId: userId ?? this.userId,
      cardNum: cardNum ?? this.cardNum,
      empCode: empCode ?? this.empCode,
      employee: employee ?? this.employee,
      edaraName: edaraName ?? this.edaraName,
      qsmName: qsmName ?? this.qsmName,
      mosmaWazefyName: mosmaWazefyName ?? this.mosmaWazefyName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      personalPhoto: personalPhoto ?? this.personalPhoto,
      empImg: empImg ?? this.empImg,
    );
  }
}
