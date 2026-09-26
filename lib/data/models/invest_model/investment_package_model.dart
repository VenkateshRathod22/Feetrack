import 'package:vlr/services/constants.dart';

class InvestmentPackageModel {
  final String? id;
  final String? title;
  final String? min;
  final String? max;
  final String? dailyPercent;
  final String? monthlyPercent;
  final String? yearlyPercent;

  InvestmentPackageModel({
    this.id,
    this.title,
    this.min,
    this.max,
    this.dailyPercent,
    this.monthlyPercent,
    this.yearlyPercent,
  });

  factory InvestmentPackageModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InvestmentPackageModel(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      min: json['min']?.toString(),
      max: json['max']?.toString(),
      dailyPercent: json['daily_percent']?.toString(),
      monthlyPercent: json['monthly_percent']?.toString(),
      yearlyPercent: json['yearly_percent']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'min': min,
      'max': max,
      'daily_percent': dailyPercent,
      'monthly_percent': monthlyPercent,
      'yearly_percent': yearlyPercent,
    };
  }

  String get minFormat => PriceConverter.convertToNumberFormat(
      double.tryParse(min ?? "0.0") ?? 0.0);

  String get manFormat => PriceConverter.convertToNumberFormat(
      double.tryParse(max ?? "0.0") ?? 0.0);
}
