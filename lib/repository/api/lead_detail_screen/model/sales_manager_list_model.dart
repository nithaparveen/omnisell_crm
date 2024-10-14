// To parse this JSON data, do
//
//     final salesManagersListModel = salesManagersListModelFromJson(jsonString);

import 'dart:convert';

SalesManagersListModel salesManagersListModelFromJson(String str) => SalesManagersListModel.fromJson(json.decode(str));

String salesManagersListModelToJson(SalesManagersListModel data) => json.encode(data.toJson());

class SalesManagersListModel {
    List<Datum>? data;

    SalesManagersListModel({
        this.data,
    });

    factory SalesManagersListModel.fromJson(Map<String, dynamic> json) => SalesManagersListModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? name;
    String? email;
    OfficeCountry? officeCountry;
    String? phoneNumber;
    Role? role;
    dynamic manager;
    int? hasPermissionToAccessUnallocatedLeads;
    dynamic lead;

    Datum({
        this.id,
        this.name,
        this.email,
        this.officeCountry,
        this.phoneNumber,
        this.role,
        this.manager,
        this.hasPermissionToAccessUnallocatedLeads,
        this.lead,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        officeCountry: json["office_country"] == null ? null : OfficeCountry.fromJson(json["office_country"]),
        phoneNumber: json["phone_number"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        manager: json["manager"],
        hasPermissionToAccessUnallocatedLeads: json["has_permission_to_access_unallocated_leads"],
        lead: json["lead"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "office_country": officeCountry?.toJson(),
        "phone_number": phoneNumber,
        "role": role?.toJson(),
        "manager": manager,
        "has_permission_to_access_unallocated_leads": hasPermissionToAccessUnallocatedLeads,
        "lead": lead,
    };
}

class OfficeCountry {
    int? id;
    String? name;
    String? countryCode;
    int? phoneCode;
    dynamic flag;

    OfficeCountry({
        this.id,
        this.name,
        this.countryCode,
        this.phoneCode,
        this.flag,
    });

    factory OfficeCountry.fromJson(Map<String, dynamic> json) => OfficeCountry(
        id: json["id"],
        name: json["name"],
        countryCode: json["country_code"],
        phoneCode: json["phone_code"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "phone_code": phoneCode,
        "flag": flag,
    };
}

class Role {
    int? id;
    String? name;

    Role({
        this.id,
        this.name,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
