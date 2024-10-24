// To parse this JSON data, do
//
//     final followUpModel = followUpModelFromJson(jsonString);

import 'dart:convert';

FollowUpModel followUpModelFromJson(String str) => FollowUpModel.fromJson(json.decode(str));

String followUpModelToJson(FollowUpModel data) => json.encode(data.toJson());

class FollowUpModel {
    List<Datum>? data;
    Links? links;
    Meta? meta;

    FollowUpModel({
        this.data,
        this.links,
        this.meta,
    });

    factory FollowUpModel.fromJson(Map<String, dynamic> json) => FollowUpModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
    };
}

class Datum {
    int? id;
    String? type;
    DateTime? followUpDate;
    AssignedToUser? assignedToUser;
    String? note;
    String? status;
    AssignedToUser? createdBy;
    AssignedToUser? lastUpdatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.type,
        this.followUpDate,
        this.assignedToUser,
        this.note,
        this.status,
        this.createdBy,
        this.lastUpdatedBy,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        followUpDate: json["follow_up_date"] == null ? null : DateTime.parse(json["follow_up_date"]),
        assignedToUser: json["assigned_to_user"] == null ? null : AssignedToUser.fromJson(json["assigned_to_user"]),
        note: json["note"],
        status: json["status"],
        createdBy: json["created_by"] == null ? null : AssignedToUser.fromJson(json["created_by"]),
        lastUpdatedBy: json["last_updated_by"] == null ? null : AssignedToUser.fromJson(json["last_updated_by"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "follow_up_date": "${followUpDate!.year.toString().padLeft(4, '0')}-${followUpDate!.month.toString().padLeft(2, '0')}-${followUpDate!.day.toString().padLeft(2, '0')}",
        "assigned_to_user": assignedToUser?.toJson(),
        "note": note,
        "status": status,
        "created_by": createdBy?.toJson(),
        "last_updated_by": lastUpdatedBy?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class AssignedToUser {
    int? id;
    String? name;
    String? email;
    OfficeCountry? officeCountry;
    String? phoneNumber;
    Role? role;
    dynamic manager;
    int? hasPermissionToAccessUnallocatedLeads;
    dynamic lead;

    AssignedToUser({
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

    factory AssignedToUser.fromJson(Map<String, dynamic> json) => AssignedToUser(
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

class Links {
    String? first;
    String? last;
    dynamic prev;
    dynamic next;

    Links({
        this.first,
        this.last,
        this.prev,
        this.next,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
    };
}

class Meta {
    int? currentPage;
    int? from;
    int? lastPage;
    List<Link>? links;
    String? path;
    int? perPage;
    int? to;
    int? total;

    Meta({
        this.currentPage,
        this.from,
        this.lastPage,
        this.links,
        this.path,
        this.perPage,
        this.to,
        this.total,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
    };
}

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
