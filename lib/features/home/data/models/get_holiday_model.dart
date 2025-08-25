

import 'package:task/features/home/domain/entities/get_holiday_entity.dart';

class HolidayModelData extends HolidayEntityData{
  const HolidayModelData({
    required super.id,
    required super.requestNumber,
    required super.requestDate,
    required super.employeeName,
    required super.holidayTypeId,
    required super.holidayTypeName,
    required super.fromDate,
    required super.toDate,
    required super.numberOfDays,
    required super.hospitalReport,
    required super.reason,
    required super.status,
    required super.requestTitle,
    required super.attachment,
    required super.canEditOrDelete,
  });

  factory HolidayModelData.fromJson(Map<String, dynamic> json) {
    return HolidayModelData(
      id: json['agaza_id'] ?? '',
      requestNumber: json['agaza_rkm_n'] ?? '',
      requestDate: json['agaza_date'] ?? '',
      employeeName: json['emp_name'] ?? '',
      holidayTypeId: json['no3_agaza'] ?? '',
      holidayTypeName: json['no3_agaza_name'] ?? '',
      fromDate: json['agaza_from_date_m'] ?? '',
      toDate: json['agaza_to_date_m'] ?? '',
      numberOfDays: json['num_days'] ?? '',
      hospitalReport: json['hospital_report'] ?? '',
      reason: json['reason'] ?? '',
      status: json['halet_talab'] ?? '',
      requestTitle: json['agaza_rkm'] ?? '',
      attachment: json['f_file'],
      canEditOrDelete: json['edit_delete'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "agaza_id": id,
      "agaza_rkm_n": requestNumber,
      "agaza_date": requestDate,
      "emp_name": employeeName,
      "no3_agaza": holidayTypeId,
      "no3_agaza_name": holidayTypeName,
      "agaza_from_date_m": fromDate,
      "agaza_to_date_m": toDate,
      "num_days": numberOfDays,
      "hospital_report": hospitalReport,
      "reason": reason,
      "halet_talab": status,
      "agaza_rkm": requestTitle,
      "f_file": attachment,
      "edit_delete": canEditOrDelete ,
    };
  }
}

class GetHolidayModel extends GetHolidayEntity {
  const GetHolidayModel({
    required super.status,
    required super.message,
    required super.holidays,
  });

  factory GetHolidayModel.fromJson(Map<String, dynamic> json) {
    return GetHolidayModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      holidays: (json['data'] as List<dynamic>?)
          ?.map((e) => HolidayModelData.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": holidays.map((e) => (e as HolidayModelData).toJson()).toList(),
    };
  }
}
