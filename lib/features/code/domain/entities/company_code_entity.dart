class CompanyCodeEntity {
  final CompanyDataEntity? data;
  final int? status;
  final String? message;

  const CompanyCodeEntity({
    this.data,
    this.status,
    this.message,
  });
}

class CompanyDataEntity {
  final int? id;
  final String? name;
  final String? baseUrl;
  final String? code;
  final String? color;
  final String? logo;
  final DateTime? date;
  final int? publisher;
  final String? showBasma;

  const CompanyDataEntity({
    this.id,
    this.name,
    this.baseUrl,
    this.code,
    this.color,
    this.logo,
    this.date,
    this.publisher,
    this.showBasma,
  });
}
