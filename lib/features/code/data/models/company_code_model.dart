import 'package:task/features/code/domain/entities/company_code_entity.dart';

class CompanyCodeModel extends CompanyCodeEntity{
  const CompanyCodeModel({
    super.data,
    super.status,
    super.message,
  });

  factory CompanyCodeModel.fromJson(Map<String, dynamic> json) {
    return CompanyCodeModel(
      data: json['data'] != null
          ? CompanyDataModel.fromJson(json['data'])
          : null,
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': (data as CompanyDataModel?)?.toJson(),
      'status': status,
      'message': message,
    };
  }
}

class CompanyDataModel extends CompanyDataEntity {
  const CompanyDataModel({
    super.id,
    super.name,
    super.baseUrl,
    super.code,
    super.color,
    super.logo,
    super.date,
    super.publisher,
    super.showBasma,
  });

  factory CompanyDataModel.fromJson(Map<String, dynamic> json) {
    return CompanyDataModel(
      id: int.tryParse(json['id'].toString()),
      name: json['name'],
      baseUrl: json['base_url'],
      code: json['code'],
      color: json['color'],
      logo: json['logo'],
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      publisher: int.tryParse(json['publisher'].toString()),
      showBasma: json['show_basma'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'base_url': baseUrl,
      'code': code,
      'color': color,
      'logo': logo,
      'date': date?.toIso8601String(),
      'publisher': publisher,
      'show_basma': showBasma,
    };
  }
}
