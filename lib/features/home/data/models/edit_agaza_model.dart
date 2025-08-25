import 'package:task/features/home/domain/entities/edit_agaza_entity.dart';
class EditAgazaModel extends EditAgazaEntity {
  const EditAgazaModel({
    int? status,
    String? message,
    dynamic data,
  }) : super(
    status: status,
    message: message,
    data: data,
  );

  factory EditAgazaModel.fromJson(Map<String, dynamic> json) {
    return EditAgazaModel(
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
