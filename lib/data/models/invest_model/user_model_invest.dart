class UserModelInvest {
  final String? signupId;
  final String? isBlock;
  final String? name;
  final String? mobile;
  final String? sponsorCode;
  final String? status;
  final String? rank;

  final DateTime? rankDate;
  final DateTime? rankExDate;

  final String? email;
  final String? walletAmount;
  final String? amount;
  final String? packageStatus;
  final String? package;
  final String? type;

  final String? sponsorid;
  final String? sponsorname;
  final String? myLevel;
  final String? boosterStatus;

  final DateTime? activeDate;
  final String? activeTime;

  final DateTime? createdDate;
  final String? createdTime;

  final dynamic pinused;
  final String? autopoolLevel;
  final String? kyc;
  final String? autopool1Level;
  final dynamic autopool2Level;
  final String? idRegTime;
  final dynamic fIdActStatus;
  final dynamic totalInc;

  final String? boosterIncomeWallet;
  final String? image;
  final String? otpVerify;
  final String? city;
  final String? country;
  final String? address;
  final String? rechargeUpgradePackage;

  UserModelInvest({
    this.signupId,
    this.isBlock,
    this.name,
    this.mobile,
    this.sponsorCode,
    this.status,
    this.rank,
    this.rankDate,
    this.rankExDate,
    this.email,
    this.walletAmount,
    this.amount,
    this.packageStatus,
    this.package,
    this.type,
    this.sponsorid,
    this.sponsorname,
    this.myLevel,
    this.boosterStatus,
    this.activeDate,
    this.activeTime,
    this.createdDate,
    this.createdTime,
    this.pinused,
    this.autopoolLevel,
    this.kyc,
    this.autopool1Level,
    this.autopool2Level,
    this.idRegTime,
    this.fIdActStatus,
    this.totalInc,
    this.boosterIncomeWallet,
    this.image,
    this.otpVerify,
    this.city,
    this.country,
    this.address,
    this.rechargeUpgradePackage,
  });

  factory UserModelInvest.fromJson(Map<String, dynamic> json) {
    return UserModelInvest(
      signupId: json["signup_id"]?.toString(),
      isBlock: json["is_block"]?.toString(),
      name: json["name"]?.toString(),
      mobile: json["mobile"]?.toString(),
      sponsorCode: json["sponsor_code"]?.toString(),
      status: json["status"]?.toString(),
      rank: json["rank"]?.toString(),

      rankDate: _parseDate(json["rank_date"]),
      rankExDate: _parseDate(json["rank_ex_date"]),

      email: json["email"]?.toString(),
      walletAmount: json["wallet_amount"]?.toString(),
      amount: json["amount"]?.toString(),
      packageStatus: json["package_status"]?.toString(),
      package: json["package"]?.toString(),
      type: json["type"]?.toString(),

      sponsorid: json["sponsorid"]?.toString(),
      sponsorname: json["sponsorname"]?.toString(),
      myLevel: json["my_level"]?.toString(),
      boosterStatus: json["booster_status"]?.toString(),

      activeDate: _parseDate(json["active_date"]),
      activeTime: json["active_time"]?.toString(),

      createdDate: _parseDate(json["created_date"]),
      createdTime: json["created_time"]?.toString(),

      pinused: json["pinused"],
      autopoolLevel: json["autopool_level"]?.toString(),
      kyc: json["kyc"]?.toString(),
      autopool1Level: json["autopool1_level"]?.toString(),
      autopool2Level: json["autopool2_level"],

      idRegTime: json["id_reg_time"]?.toString(),
      fIdActStatus: json["f_id_act_status"],
      totalInc: json["total_inc"],

      boosterIncomeWallet:
          json["booster_income_wallet"]?.toString(),

      image: json["image"]?.toString(),
      otpVerify: json["otp_verify"]?.toString(),
      city: json["city"]?.toString(),
      country: json["country"]?.toString(),
      address: json["address"]?.toString(),

      rechargeUpgradePackage:
          json["recharge_upgrade_package"]?.toString(),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;

    final String date = value.toString();

    if (date.isEmpty) return null;

    return DateTime.tryParse(date);
  }
}