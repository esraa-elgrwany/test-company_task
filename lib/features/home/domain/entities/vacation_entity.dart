class VacationEntityData {
  final String vacationId;
  final String vacationName;
  final String mowazfBadal;
  final String minDays;
  final String maxDays;

  const VacationEntityData({
    required this.vacationId,
    required this.vacationName,
    required this.mowazfBadal,
    required this.minDays,
    required this.maxDays,
  });
}

class VacationEntity{
  final int status;
  final String message;
  final List<VacationEntityData> data;

  const VacationEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}
