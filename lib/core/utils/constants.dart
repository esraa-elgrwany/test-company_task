import 'package:task/core/helper/company_manager/company_manager.dart';

class Constants {
   static const String companyCodeUrl="https://alatheertech.com/basma/Api/All_Companies_test";
   static final String baseUrl=CompanyManager().company?.baseUrl??"https://fallback-base-url.com";
}
