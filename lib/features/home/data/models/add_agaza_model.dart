import 'package:task/features/home/domain/entities/add_agaza_entity.dart';
class AddAgazaModel extends AddAgazaEntity {
  AddAgazaModel({
    int? status,
    String? message,
    dynamic data,
  }) : super(
    status: status,
    message: message,
    data: data,
  );

  factory AddAgazaModel.fromJson(Map<String, dynamic> json) {
    return AddAgazaModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}

