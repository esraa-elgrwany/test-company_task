class HolidayEntityData{
  final String id;
  final String requestNumber;
  final String requestDate;
  final String employeeName;
  final String holidayTypeId;
  final String holidayTypeName;
  final String fromDate;
  final String toDate;
  final String numberOfDays;
  final String hospitalReport;
  final String reason;
  final String status; // جارٍ، وارد، مقبول، مرفوض
  final String requestTitle;
  final String attachment;
  final String canEditOrDelete;

  const HolidayEntityData({
    required this.id,
    required this.requestNumber,
    required this.requestDate,
    required this.employeeName,
    required this.holidayTypeId,
    required this.holidayTypeName,
    required this.fromDate,
    required this.toDate,
    required this.numberOfDays,
    required this.hospitalReport,
    required this.reason,
    required this.status,
    required this.requestTitle,
    required this.attachment,
    required this.canEditOrDelete,
  });
}

class GetHolidayEntity {
  final int status;
  final String message;
  final List<HolidayEntityData> holidays;

  const GetHolidayEntity({
    required this.status,
    required this.message,
    required this.holidays,
  });
}
