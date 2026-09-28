
class BankModelInvest {
    final String? id;
    final String? userId;
    final String? accountNo;
    final String? ifsc;
    final String? bankName;
    final String? accountHolderName;
    final String? accountType;
    final String? status;
    final String? createdAt;
    final String? updatedAt;

    BankModelInvest({
        this.id,
        this.userId,
        this.accountNo,
        this.ifsc,
        this.bankName,
        this.accountHolderName,
        this.accountType,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory BankModelInvest.fromJson(Map<String, dynamic> json) => BankModelInvest(
        id: json["id"],
        userId: json["user_id"],
        accountNo: json["account_no"],
        ifsc: json["ifsc"],
        bankName: json["bank_name"],
        accountHolderName: json["account_holder_name"],
        accountType: json["account_type"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "account_no": accountNo,
        "ifsc": ifsc,
        "bank_name": bankName,
        "account_holder_name": accountHolderName,
        "account_type": accountType,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

