// To parse this JSON data, do
//
//     final callModel = callModelFromJson(jsonString);

import 'dart:convert';

WhatsAppModel callModelFromJson(String str) => WhatsAppModel.fromJson(json.decode(str));

String callModelToJson(WhatsAppModel data) => json.encode(data.toJson());

class WhatsAppModel {
    List<Datum>? data;
    Links? links;
    Meta? meta;

    WhatsAppModel({
        this.data,
        this.links,
        this.meta,
    });

    factory WhatsAppModel.fromJson(Map<String, dynamic> json) => WhatsAppModel(
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
    String? to;
    dynamic subject;
    String? body;
    dynamic cc;
    String? type;
    dynamic from;
    dynamic fromOriginal;
    DateTime? messageDate;
    AtedBy? createdBy;
    AtedBy? lastUpdatedBy;
    dynamic createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.to,
        this.subject,
        this.body,
        this.cc,
        this.type,
        this.from,
        this.fromOriginal,
        this.messageDate,
        this.createdBy,
        this.lastUpdatedBy,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        to: json["to"],
        subject: json["subject"],
        body: json["body"],
        cc: json["cc"],
        type: json["type"],
        from: json["from"],
        fromOriginal: json["from_original"],
        messageDate: json["message_date"] == null ? null : DateTime.parse(json["message_date"]),
        createdBy: json["created_by"] == null ? null : AtedBy.fromJson(json["created_by"]),
        lastUpdatedBy: json["last_updated_by"] == null ? null : AtedBy.fromJson(json["last_updated_by"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "to": to,
        "subject": subject,
        "body": body,
        "cc": cc,
        "type": type,
        "from": from,
        "from_original": fromOriginal,
        "message_date": messageDate?.toIso8601String(),
        "created_by": createdBy?.toJson(),
        "last_updated_by": lastUpdatedBy?.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class AtedBy {
    int? id;
    String? name;
    String? email;
    dynamic officeCountry;
    String? phoneNumber;
    Role? role;
    dynamic manager;
    int? hasPermissionToAccessUnallocatedLeads;
    dynamic lead;

    AtedBy({
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

    factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
        id: json["id"],
        name: json["name"]!,
        email: json["email"]!,
        officeCountry: json["office_country"],
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
        "office_country": officeCountry,
        "phone_number": phoneNumber,
        "role": role?.toJson(),
        "manager": manager,
        "has_permission_to_access_unallocated_leads": hasPermissionToAccessUnallocatedLeads,
        "lead": lead,
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
