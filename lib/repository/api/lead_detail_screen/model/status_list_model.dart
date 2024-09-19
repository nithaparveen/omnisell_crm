// To parse this JSON data, do
//
//     final statusListModel = statusListModelFromJson(jsonString);

import 'dart:convert';

StatusListModel statusListModelFromJson(String str) => StatusListModel.fromJson(json.decode(str));

String statusListModelToJson(StatusListModel data) => json.encode(data.toJson());

class StatusListModel {
    List<Datum>? data;

    StatusListModel({
        this.data,
    });

    factory StatusListModel.fromJson(Map<String, dynamic> json) => StatusListModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? name;
    String? description;
    String? colour;
    String? actionType;
    int? progressPercentage;
    List<dynamic>? subStages;

    Datum({
        this.id,
        this.name,
        this.description,
        this.colour,
        this.actionType,
        this.progressPercentage,
        this.subStages,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        colour: json["colour"],
        actionType: json["action_type"],
        progressPercentage: json["progress_percentage"],
        subStages: json["sub_stages"] == null ? [] : List<dynamic>.from(json["sub_stages"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "colour": colour,
        "action_type": actionType,
        "progress_percentage": progressPercentage,
        "sub_stages": subStages == null ? [] : List<dynamic>.from(subStages!.map((x) => x)),
    };
}
