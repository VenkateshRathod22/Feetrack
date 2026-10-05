import 'dart:convert';

class TicketModelInvest {
  final String? id;
  final String? userId;
  final String? subject;
  final String? userMsg;
  final String? adminMsg;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TicketModelInvest({
    this.id,
    this.userId,
    this.subject,
    this.userMsg,
    this.adminMsg,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TicketModelInvest.fromMap(Map<String, dynamic> map) {
    return TicketModelInvest(
      id: map['id']?.toString(),
      userId: map['userid']?.toString(),
      subject: map['subject']?.toString(),
      userMsg: map['usermsg']?.toString(),
      adminMsg: map['adminmsg']?.toString(),
      status: map['status']?.toString(),
      createdAt: _parseDate(map['created_at']),
      updatedAt: _parseDate(map['updated_at']),
    );
  }

  factory TicketModelInvest.fromJson(String source) =>
      TicketModelInvest.fromMap(jsonDecode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userId,
      'subject': subject,
      'usermsg': userMsg,
      'adminmsg': adminMsg,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) {
      return null;
    }

    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return null;
    }
  }
}