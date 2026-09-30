import 'package:intl/intl.dart';
import 'package:vlr/services/constants.dart';

class FundHistoryModelInvest {
  final String id;
  final String incomeTypeId;
  final String platform;
  final String userId;
  final String? image;
  final String amount;
  final String transactionId;
  final String? mode;
  final String? remark;
  final String? adminRemark;
  final String date;
  final String approveStatus;
  final String? approveDate;
  final String? approveTime;
  final String? time;
  final String type;
  final String status;
  final String? accessKey;
  final String? paymentId;
  final String createdAt;
  final String updatedAt;

  const FundHistoryModelInvest({
    this.id = '',
    this.incomeTypeId = '',
    this.platform = '',
    this.userId = '',
    this.image,
    this.amount = '0',
    this.transactionId = '',
    this.mode,
    this.remark,
    this.adminRemark,
    this.date = '',
    this.approveStatus = '',
    this.approveDate,
    this.approveTime,
    this.time,
    this.type = '',
    this.status = '',
    this.accessKey,
    this.paymentId,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory FundHistoryModelInvest.fromJson(
    Map<String, dynamic> json,
  ) {
    return FundHistoryModelInvest(
      id: json['id']?.toString() ?? '',
      incomeTypeId: json['income_type_id']?.toString() ?? '',
      platform: json['platform']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',

      // Nullable fields
      image: json['image']?.toString(),
      mode: json['mode']?.toString(),
      remark: json['remark']?.toString(),
      adminRemark: json['adminremark']?.toString(),
      approveDate: json['approve_date']?.toString(),
      approveTime: json['approve_time']?.toString(),
      time: json['time']?.toString(),
      accessKey: json['accesskey']?.toString(),
      paymentId: json['paymentid']?.toString(),

      // Non-null fields with safe fallback
      amount: json['amount']?.toString() ?? '0',
      transactionId: json['transaction_id']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      approveStatus: json['approve_status']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  String get amountFormat =>
      PriceConverter.convertToNumberFormat(double.tryParse(amount) ?? 0.0);
  bool get isApproveStatus => approveStatus == "1" ? true : false;
  String get data => formattedCreatedAt;

  String get formattedCreatedAt {
    final DateTime? dateTime = isApproveStatus
        ? DateTime.tryParse(createdAt)
        : DateTime.tryParse(updatedAt);

    if (dateTime == null) {
      return createdAt;
    }

    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }
}
