class LoginEntity {
  final int? status;
  final String? message;
  final int? logoutOption;
  final UserDataEntity? data;

  const LoginEntity({
    this.status,
    this.message,
    this.logoutOption,
    this.data,
  });
}

class UserDataEntity {
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

  const UserDataEntity({
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
  });
}
