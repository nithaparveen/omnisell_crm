// To parse this JSON data, do
//
//     final communicationSummaryModel = communicationSummaryModelFromJson(jsonString);

import 'dart:convert';

CommunicationSummaryModel communicationSummaryModelFromJson(String str) => CommunicationSummaryModel.fromJson(json.decode(str));

String communicationSummaryModelToJson(CommunicationSummaryModel data) => json.encode(data.toJson());

class CommunicationSummaryModel {
    Data? data;

    CommunicationSummaryModel({
        this.data,
    });

    factory CommunicationSummaryModel.fromJson(Map<String, dynamic> json) => CommunicationSummaryModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    int? emailSendSummary;
    int? emailReceiveSummary;
    int? whatsappSendSummary;
    int? whatsappReceiveSummary;

    Data({
        this.emailSendSummary,
        this.emailReceiveSummary,
        this.whatsappSendSummary,
        this.whatsappReceiveSummary,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        emailSendSummary: json["email_send_summary"],
        emailReceiveSummary: json["email_receive_summary"],
        whatsappSendSummary: json["whatsapp_send_summary"],
        whatsappReceiveSummary: json["whatsapp_receive_summary"],
    );

    Map<String, dynamic> toJson() => {
        "email_send_summary": emailSendSummary,
        "email_receive_summary": emailReceiveSummary,
        "whatsapp_send_summary": whatsappSendSummary,
        "whatsapp_receive_summary": whatsappReceiveSummary,
    };
}
