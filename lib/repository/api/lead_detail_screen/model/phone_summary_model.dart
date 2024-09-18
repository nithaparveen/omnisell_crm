// To parse this JSON data, do
//
//     final phoneSummaryModel = phoneSummaryModelFromJson(jsonString);

import 'dart:convert';

PhoneSummaryModel phoneSummaryModelFromJson(String str) => PhoneSummaryModel.fromJson(json.decode(str));

String phoneSummaryModelToJson(PhoneSummaryModel data) => json.encode(data.toJson());

class PhoneSummaryModel {
    Data? data;

    PhoneSummaryModel({
        this.data,
    });

    factory PhoneSummaryModel.fromJson(Map<String, dynamic> json) => PhoneSummaryModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    int? callsInbound;
    int? callsOutbound;

    Data({
        this.callsInbound,
        this.callsOutbound,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        callsInbound: json["calls_inbound"],
        callsOutbound: json["calls_outbound"],
    );

    Map<String, dynamic> toJson() => {
        "calls_inbound": callsInbound,
        "calls_outbound": callsOutbound,
    };
}
