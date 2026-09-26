// To parse this JSON data, do
//
//     final homeInvestModel = homeInvestModelFromJson(jsonString);

import 'dart:convert';

HomeInvestModel homeInvestModelFromJson(String str) => HomeInvestModel.fromJson(json.decode(str));

String homeInvestModelToJson(HomeInvestModel data) => json.encode(data.toJson());

class HomeInvestModel {
    final List<Notification>? notification;
    final String? directActive;
    final String? directInactive;
    final String? activelevelTeam;
    final String? inactiveLevelTeam;
    final String? directIncome;
    final String? levelIncome;
    final String? roiIncome;
    final String? roiLevelincome;
    final String? rechargeIncome;
    final String? rechargeLevel;
    final String? totalIncome;
    final String? todayIncome;
    final String? pendingWithdrawal;
    final String? approveWithdrawal;
    final String? rejectWithdrawal;
    final String? pendingFund;
    final String? approveFund;
    final String? rejectFund;
    final String? completeRecharge;
    final String? faieldRecharge;
    final String? pendingRecharge;
    final News? news;

    HomeInvestModel({
        this.notification,
        this.directActive,
        this.directInactive,
        this.activelevelTeam,
        this.inactiveLevelTeam,
        this.directIncome,
        this.levelIncome,
        this.roiIncome,
        this.roiLevelincome,
        this.rechargeIncome,
        this.rechargeLevel,
        this.totalIncome,
        this.todayIncome,
        this.pendingWithdrawal,
        this.approveWithdrawal,
        this.rejectWithdrawal,
        this.pendingFund,
        this.approveFund,
        this.rejectFund,
        this.completeRecharge,
        this.faieldRecharge,
        this.pendingRecharge,
        this.news,
    });

    factory HomeInvestModel.fromJson(Map<String, dynamic> json) => HomeInvestModel(
        notification: json["notification"] == null ? [] : List<Notification>.from(json["notification"]!.map((x) => Notification.fromJson(x))),
        directActive: json["directActive"],
        directInactive: json["directInactive"],
        activelevelTeam: json["activelevelTeam"],
        inactiveLevelTeam: json["inactiveLevelTeam"],
        directIncome: json["directIncome"],
        levelIncome: json["levelIncome"],
        roiIncome: json["roiIncome"],
        roiLevelincome: json["roiLevelincome"],
        rechargeIncome: json["rechargeIncome"],
        rechargeLevel: json["rechargeLevel"],
        totalIncome: json["totalIncome"],
        todayIncome: json["todayIncome"],
        pendingWithdrawal: json["pendingWithdrawal"],
        approveWithdrawal: json["approveWithdrawal"],
        rejectWithdrawal: json["rejectWithdrawal"],
        pendingFund: json["pendingFund"],
        approveFund: json["approveFund"],
        rejectFund: json["rejectFund"],
        completeRecharge: json["completeRecharge"],
        faieldRecharge: json["faieldRecharge"],
        pendingRecharge: json["pendingRecharge"],
        news: json["news"] == null ? null : News.fromJson(json["news"]),
    );

    Map<String, dynamic> toJson() => {
        "notification": notification == null ? [] : List<dynamic>.from(notification!.map((x) => x.toJson())),
        "directActive": directActive,
        "directInactive": directInactive,
        "activelevelTeam": activelevelTeam,
        "inactiveLevelTeam": inactiveLevelTeam,
        "directIncome": directIncome,
        "levelIncome": levelIncome,
        "roiIncome": roiIncome,
        "roiLevelincome": roiLevelincome,
        "rechargeIncome": rechargeIncome,
        "rechargeLevel": rechargeLevel,
        "totalIncome": totalIncome,
        "todayIncome": todayIncome,
        "pendingWithdrawal": pendingWithdrawal,
        "approveWithdrawal": approveWithdrawal,
        "rejectWithdrawal": rejectWithdrawal,
        "pendingFund": pendingFund,
        "approveFund": approveFund,
        "rejectFund": rejectFund,
        "completeRecharge": completeRecharge,
        "faieldRecharge": faieldRecharge,
        "pendingRecharge": pendingRecharge,
        "news": news?.toJson(),
    };
}

class News {
    final String? id;
    final String? news;
    final String? newimage;
    final String? status;

    News({
        this.id,
        this.news,
        this.newimage,
        this.status,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        news: json["news"],
        newimage: json["newimage"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "news": news,
        "newimage": newimage,
        "status": status,
    };
}

class Notification {
    final String? title;
    final String? message;
    final String? image;

    Notification({
        this.title,
        this.message,
        this.image,
    });

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json["title"],
        message: json["message"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "image": image,
    };
}
