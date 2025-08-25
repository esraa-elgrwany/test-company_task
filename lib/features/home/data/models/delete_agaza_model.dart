import 'package:task/features/home/domain/entities/delete_agaza_entity.dart';

class DeleteAgazaModel extends DeleteAgazaEntity {
  const DeleteAgazaModel({
    int? status,
    String? message,
    dynamic data,
  }) : super(
    status: status,
    message: message,
    data: data,
  );

  factory DeleteAgazaModel.fromJson(Map<String, dynamic> json) {
    return DeleteAgazaModel(
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
