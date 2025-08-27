import 'dart:convert';
import 'package:task/core/cache/shared_preferences.dart';
import 'package:task/features/code/data/models/company_code_model.dart';
import 'package:flutter/material.dart';

class CompanyManager {
  static final CompanyManager _instance = CompanyManager._internal();
  factory CompanyManager() => _instance;
  CompanyManager._internal();

  CompanyDataModel? _company;

  Future<void> saveCompany(CompanyDataModel company) async {
    _company = company;
    await CacheData.saveData(
      key: "companyModel",
      data: jsonEncode(company.toJson()),
    );
  }

  CompanyDataModel? get company {
    if (_company != null) return _company;
    final raw = CacheData.getData(key: "companyModel");
    if (raw != null) {
      _company = CompanyDataModel.fromJson(jsonDecode(raw));
    }
    return _company;
  }


  String get baseUrl {
    return company?.baseUrl ?? "https://fallback-base-url.com";
  }


  Color get primaryColor {
    final hex = company?.color ?? "";
    return _hexToColor(hex);
  }

  String get logo {
    return company?.logo ?? "";
  }

  String get name {
    return company?.name ?? "no name";
  }

  Color _hexToColor(String? hex) {
    if (hex == null || hex.isEmpty) {
      return Colors.blue;
    }
    hex = hex.replaceFirst("#", "");
    if (hex.length == 6) {
      hex = "FF$hex";
    }
    try {
      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return Colors.blue;
    }
  }

  Future<void> clearCompany() async {
    _company = null;
    await CacheData.removeData("companyModel");
  }
}

