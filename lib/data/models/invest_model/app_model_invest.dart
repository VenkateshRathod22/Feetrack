// To parse this JSON data, do
//
//     final appSettingInvestModel = appSettingInvestModelFromJson(jsonString);

import 'dart:convert';

AppSettingInvestModel appSettingInvestModelFromJson(String str) => AppSettingInvestModel.fromJson(json.decode(str));

String appSettingInvestModelToJson(AppSettingInvestModel data) => json.encode(data.toJson());

class AppSettingInvestModel {
    final FundSetting? fundSetting;
    final WithdrawSetting? withdrawSetting;
    final Setting? setting;
    final List<IncomeFrequency>? incomeFrequency;

    AppSettingInvestModel({
        this.fundSetting,
        this.withdrawSetting,
        this.setting,
        this.incomeFrequency,
    });

    factory AppSettingInvestModel.fromJson(Map<String, dynamic> json) => AppSettingInvestModel(
        fundSetting: json["fundSetting"] == null ? null : FundSetting.fromJson(json["fundSetting"]),
        withdrawSetting: json["withdrawSetting"] == null ? null : WithdrawSetting.fromJson(json["withdrawSetting"]),
        setting: json["Setting"] == null ? null : Setting.fromJson(json["Setting"]),
        incomeFrequency: json["incomeFrequency"] == null ? [] : List<IncomeFrequency>.from(json["incomeFrequency"]!.map((x) => IncomeFrequency.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "fundSetting": fundSetting?.toJson(),
        "withdrawSetting": withdrawSetting?.toJson(),
        "Setting": setting?.toJson(),
        "incomeFrequency": incomeFrequency == null ? [] : List<dynamic>.from(incomeFrequency!.map((x) => x.toJson())),
    };
}

class FundSetting {
    final String? id;
    final String? min;
    final String? max;
    final String? fund;
    final String? accountName;
    final String? accountNo;
    final String? ifsc;
    final String? name;
    final String? upi;
    final String? qr;
    final String? updateDate;

    FundSetting({
        this.id,
        this.min,
        this.max,
        this.fund,
        this.accountName,
        this.accountNo,
        this.ifsc,
        this.name,
        this.upi,
        this.qr,
        this.updateDate,
    });

    factory FundSetting.fromJson(Map<String, dynamic> json) => FundSetting(
        id: json["id"],
        min: json["min"],
        max: json["max"],
        fund: json["fund"],
        accountName: json["account_name"],
        accountNo: json["account_no"],
        ifsc: json["ifsc"],
        name: json["name"],
        upi: json["upi"],
        qr: json["qr"],
        updateDate: json["update_date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "min": min,
        "max": max,
        "fund": fund,
        "account_name": accountName,
        "account_no": accountNo,
        "ifsc": ifsc,
        "name": name,
        "upi": upi,
        "qr": qr,
        "update_date": updateDate,
    };
}

class IncomeFrequency {
    final String? id;
    final String? incomeType;

    IncomeFrequency({
        this.id,
        this.incomeType,
    });

    factory IncomeFrequency.fromJson(Map<String, dynamic> json) => IncomeFrequency(
        id: json["id"],
        incomeType: json["income_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "income_type": incomeType,
    };
}

class Setting {
    final String? id;
    final String? mobile;
    final String? email;
    final dynamic emailfrom;
    final String? address;
    final String? title;
    final String? url;
    final dynamic package;
    final String? pre;
    final String? currency;
    final String? bitly;
    final String? status;
    final String? logo;
    final String? icon;
    final String? bg;
    final String? whatsapp;
    final String? panelBg;
    final String? impsStatus;

    Setting({
        this.id,
        this.mobile,
        this.email,
        this.emailfrom,
        this.address,
        this.title,
        this.url,
        this.package,
        this.pre,
        this.currency,
        this.bitly,
        this.status,
        this.logo,
        this.icon,
        this.bg,
        this.whatsapp,
        this.panelBg,
        this.impsStatus,
    });

    factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        id: json["id"],
        mobile: json["mobile"],
        email: json["email"],
        emailfrom: json["emailfrom"],
        address: json["address"],
        title: json["title"],
        url: json["url"],
        package: json["package"],
        pre: json["pre"],
        currency: json["currency"],
        bitly: json["bitly"],
        status: json["status"],
        logo: json["logo"],
        icon: json["icon"],
        bg: json["bg"],
        whatsapp: json["whatsapp"],
        panelBg: json["panel_bg"],
        impsStatus: json["imps_status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mobile": mobile,
        "email": email,
        "emailfrom": emailfrom,
        "address": address,
        "title": title,
        "url": url,
        "package": package,
        "pre": pre,
        "currency": currency,
        "bitly": bitly,
        "status": status,
        "logo": logo,
        "icon": icon,
        "bg": bg,
        "whatsapp": whatsapp,
        "panel_bg": panelBg,
        "imps_status": impsStatus,
    };
}

class WithdrawSetting {
    final String? id;
    final String? admincharge;
    final String? mintransactions;
    final String? startTime;
    final String? startAm;
    final String? endTime;
    final String? endAm;
    final String? minAmt;
    final String? maxAmt;
    final String? day;
    final String? status;
    final String? paymentsetting;

    WithdrawSetting({
        this.id,
        this.admincharge,
        this.mintransactions,
        this.startTime,
        this.startAm,
        this.endTime,
        this.endAm,
        this.minAmt,
        this.maxAmt,
        this.day,
        this.status,
        this.paymentsetting,
    });

    factory WithdrawSetting.fromJson(Map<String, dynamic> json) => WithdrawSetting(
        id: json["id"],
        admincharge: json["admincharge"],
        mintransactions: json["mintransactions"],
        startTime: json["start_time"],
        startAm: json["start_am"],
        endTime: json["end_time"],
        endAm: json["end_am"],
        minAmt: json["min_amt"],
        maxAmt: json["max_amt"],
        day: json["day"],
        status: json["status"],
        paymentsetting: json["paymentsetting"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "admincharge": admincharge,
        "mintransactions": mintransactions,
        "start_time": startTime,
        "start_am": startAm,
        "end_time": endTime,
        "end_am": endAm,
        "min_amt": minAmt,
        "max_amt": maxAmt,
        "day": day,
        "status": status,
        "paymentsetting": paymentsetting,
    };
}
