class EmployeeEntity {
  final int? status;
  final String? message;
  final List<EmployeeEntityData>? data;

  const EmployeeEntity({
    this.status,
    this.message,
    this.data,
  });
}

class EmployeeEntityData {
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

  const EmployeeEntityData({
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
  });
}
