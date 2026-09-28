import 'package:intl/intl.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/date_formatters_and_converters.dart';

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

  String get packageFormat => PriceConverter.convertToNumberFormat(
      double.tryParse(package ?? "0.0") ?? 0.0);

  /// 30 May 2025
  String get packageDateFormat {
    if (packageDate == null || packageDate!.trim().isEmpty) {
      return "";
    }

    try {
      final date = DateTime.parse(packageDate!);

      return DateFormatters().dMonthYear.format(date);
    } catch (e) {
      return packageDate ?? "";
    }
  }

  /// 05:49 PM
  String get packageTimeFormat {
    if (packageTime == null || packageTime!.trim().isEmpty) {
      return "";
    }

    try {
      final time = DateFormat("hh:mm a").parse(
        packageTime!.toUpperCase(),
      );

      return DateFormat("hh:mm a").format(time);
    } catch (e) {
      return packageTime ?? "";
    }
  }

  /// 2.00%
  String get perFormat {
    if (per == null || per!.trim().isEmpty) {
      return "";
    }

    return "$per%";
  }

  bool get withdrawStatusFormat => withdrawStatus == "1" ? true : false;
}
