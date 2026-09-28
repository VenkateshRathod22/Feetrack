class ActivationHistoryModelInvest {
  final String? uniqueId;
  final String? userId;
  final String? activatedBy;
  final String? packageType;
  final String? package;
  final String? incomeType;
  final String? per;
  final String? packageDate;
  final String? packageTime;
  final String? withdrawStatus;

  ActivationHistoryModelInvest({
    this.uniqueId,
    this.userId,
    this.activatedBy,
    this.packageType,
    this.package,
    this.incomeType,
    this.per,
    this.packageDate,
    this.packageTime,
    this.withdrawStatus,
  });

  factory ActivationHistoryModelInvest.fromJson(
    Map<String, dynamic> json,
  ) {
    final incomeTypeData = json['income_type'];

    return ActivationHistoryModelInvest(
      uniqueId: json['unique_id']?.toString(),
      userId: json['user_id']?.toString(),
      activatedBy: json['activated_by']?.toString(),
      packageType: json['package_type']?.toString(),
      package: json['package']?.toString(),
      incomeType: incomeTypeData is Map
          ? incomeTypeData['income_type']?.toString()
          : incomeTypeData?.toString(),
      per: json['per']?.toString(),
      packageDate: json['package_date']?.toString(),
      packageTime: json['package_time']?.toString(),
      withdrawStatus: json['withdraw_status']?.toString(),
    );
  }
}
