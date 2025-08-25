import '../../domain/entities/vacation_entity.dart';

class VacationModelData extends VacationEntityData{
  const VacationModelData({
    required String vacationId,
    required String vacationName,
    required String mowazfBadal,
    required String minDays,
    required String maxDays,
  }) : super(
    vacationId: vacationId,
    vacationName: vacationName,
    mowazfBadal: mowazfBadal,
    minDays: minDays,
    maxDays: maxDays,
  );

  factory VacationModelData.fromJson(Map<String, dynamic> json) {
    return VacationModelData(
      vacationId: json['vacation_id'] ?? '',
      vacationName: json['vacation_name'] ?? '',
      mowazfBadal: json['mowazf_badel'] ?? '',
      minDays: json['min_days'] ?? '',
      maxDays: json['max_days'] ?? '',
    );
  }
}

class VacationModel extends VacationEntity {
  const VacationModel({
    required int status,
    required String message,
    required List<VacationModelData> data,
  }) : super(
    status: status,
    message: message,
    data: data,
  );

  factory VacationModel.fromJson(Map<String, dynamic> json) {
    return VacationModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => VacationModelData.fromJson(e))
          .toList(),
    );
  }
}
