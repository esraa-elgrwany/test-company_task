class AddSignatureEntity {
  AddSignatureEntity({
      this.status, 
      this.message, 
      this.data,});

  int? status;
  String? message;
  AddSignatureEntityData? data;
}

class AddSignatureEntityData {
  AddSignatureEntityData({
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
      this.empSignature,});

  AddSignatureEntityData.fromJson(dynamic json) {
    userId = json['user_id'];
    empId = json['emp_id'];
    empCode = json['emp_code'];
    cardNum = json['card_num'];
    employee = json['employee'];
    edaraName = json['edara_name'];
    qsmName = json['qsm_name'];
    personalPhoto = json['personal_photo'];
    usersSignatures = json['users_signatures'];
    mosmaWazefyName = json['mosma_wazefy_name'];
    phoneNumber = json['phone_number'];
    empImg = json['emp_img'];
    empSignature = json['emp_signature'];
  }
  String? userId;
  String? empId;
  String? empCode;
  String? cardNum;
  String? employee;
  String? edaraName;
  String? qsmName;
  String? personalPhoto;
  String? usersSignatures;
  String? mosmaWazefyName;
  String? phoneNumber;
  String? empImg;
  String? empSignature;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['emp_id'] = empId;
    map['emp_code'] = empCode;
    map['card_num'] = cardNum;
    map['employee'] = employee;
    map['edara_name'] = edaraName;
    map['qsm_name'] = qsmName;
    map['personal_photo'] = personalPhoto;
    map['users_signatures'] = usersSignatures;
    map['mosma_wazefy_name'] = mosmaWazefyName;
    map['phone_number'] = phoneNumber;
    map['emp_img'] = empImg;
    map['emp_signature'] = empSignature;
    return map;
  }

}