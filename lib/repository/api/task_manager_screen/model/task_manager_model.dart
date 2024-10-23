// To parse this JSON data, do
//
//     final taskManagerModel = taskManagerModelFromJson(jsonString);

import 'dart:convert';

TaskManagerModel taskManagerModelFromJson(String str) => TaskManagerModel.fromJson(json.decode(str));

String taskManagerModelToJson(TaskManagerModel data) => json.encode(data.toJson());

class TaskManagerModel {
    List<Datum>? data;
    Links? links;
    Meta? meta;

    TaskManagerModel({
        this.data,
        this.links,
        this.meta,
    });

    factory TaskManagerModel.fromJson(Map<String, dynamic> json) => TaskManagerModel(
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
    String? title;
    String? description;
    dynamic startDate;
    dynamic endDate;
    DateTime? dueDate;
    AssignedByUser? assignedToUser;
    Lead? lead;
    AssignedByUser? assignedByUser;
    dynamic reviewer;
    String? priority;
    String? status;
    dynamic statusNote;
    int? archived;
    AssignedByUser? createdBy;
    AssignedByUser? lastUpdatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.title,
        this.description,
        this.startDate,
        this.endDate,
        this.dueDate,
        this.assignedToUser,
        this.lead,
        this.assignedByUser,
        this.reviewer,
        this.priority,
        this.status,
        this.statusNote,
        this.archived,
        this.createdBy,
        this.lastUpdatedBy,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        assignedToUser: json["assignedToUser"] == null ? null : AssignedByUser.fromJson(json["assignedToUser"]),
        lead: json["lead"] == null ? null : Lead.fromJson(json["lead"]),
        assignedByUser: json["assignedByUser"] == null ? null : AssignedByUser.fromJson(json["assignedByUser"]),
        reviewer: json["reviewer"],
        priority:json["priority"],
        status: json["status"],
        statusNote: json["status_note"],
        archived: json["archived"],
        createdBy: json["createdBy"] == null ? null : AssignedByUser.fromJson(json["createdBy"]),
        lastUpdatedBy: json["lastUpdatedBy"] == null ? null : AssignedByUser.fromJson(json["lastUpdatedBy"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "start_date": startDate,
        "end_date": endDate,
        "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "assignedToUser": assignedToUser?.toJson(),
        "lead": lead?.toJson(),
        "assignedByUser": assignedByUser?.toJson(),
        "reviewer": reviewer,
        "priority": priority,
        "status": status,
        "status_note": statusNote,
        "archived": archived,
        "createdBy": createdBy?.toJson(),
        "lastUpdatedBy": lastUpdatedBy?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class AssignedByUser {
    int? id;
    String? name;
    String? email;
    OfficeCountry? officeCountry;
    String? phoneNumber;
    Role? role;
    dynamic manager;
    int? hasPermissionToAccessUnallocatedLeads;
    dynamic lead;

    AssignedByUser({
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

    factory AssignedByUser.fromJson(Map<String, dynamic> json) => AssignedByUser(
        id: json["id"],
        name: json["name"]!,
        email: json["email"]!,
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
        name: json["name"]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Lead {
    int? id;
    String? leadUniqueId;
    String? leadType;
    dynamic title;
    String? name;
    String? email;
    String? city;
    dynamic dateOfBirth;
    dynamic phoneCountryCode;
    int? phoneNumber;
    dynamic alternatePhoneCountryCode;
    dynamic alternatePhoneNumber;
    dynamic whatsappCountryCode;
    int? whatsappNumber;
    dynamic studentCode;
    AssignedToOffice? assignedToOffice;
    dynamic assignedToCounsellor;
    dynamic assignedToApplicationManager;
    int? closed;

    Lead({
        this.id,
        this.leadUniqueId,
        this.leadType,
        this.title,
        this.name,
        this.email,
        this.city,
        this.dateOfBirth,
        this.phoneCountryCode,
        this.phoneNumber,
        this.alternatePhoneCountryCode,
        this.alternatePhoneNumber,
        this.whatsappCountryCode,
        this.whatsappNumber,
        this.studentCode,
        this.assignedToOffice,
        this.assignedToCounsellor,
        this.assignedToApplicationManager,
        this.closed,
    });

    factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        id: json["id"],
        leadUniqueId: json["lead_unique_id"],
        leadType: json["lead_type"],
        title: json["title"],
        name: json["name"],
        email: json["email"],
        city: json["city"],
        dateOfBirth: json["date_of_birth"],
        phoneCountryCode: json["phone_country_code"],
        phoneNumber: json["phone_number"],
        alternatePhoneCountryCode: json["alternate_phone_country_code"],
        alternatePhoneNumber: json["alternate_phone_number"],
        whatsappCountryCode: json["whatsapp_country_code"],
        whatsappNumber: json["whatsapp_number"],
        studentCode: json["student_code"],
        assignedToOffice: json["assignedToOffice"] == null ? null : AssignedToOffice.fromJson(json["assignedToOffice"]),
        assignedToCounsellor: json["assignedToCounsellor"],
        assignedToApplicationManager: json["assignedToApplicationManager"],
        closed: json["closed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lead_unique_id": leadUniqueId,
        "lead_type": leadType,
        "title": title,
        "name": name,
        "email": email,
        "city": city,
        "date_of_birth": dateOfBirth,
        "phone_country_code": phoneCountryCode,
        "phone_number": phoneNumber,
        "alternate_phone_country_code": alternatePhoneCountryCode,
        "alternate_phone_number": alternatePhoneNumber,
        "whatsapp_country_code": whatsappCountryCode,
        "whatsapp_number": whatsappNumber,
        "student_code": studentCode,
        "assignedToOffice": assignedToOffice?.toJson(),
        "assignedToCounsellor": assignedToCounsellor,
        "assignedToApplicationManager": assignedToApplicationManager,
        "closed": closed,
    };
}

class AssignedToOffice {
    int? id;
    String? name;
    String? address;
    String? emailIds;
    String? phoneNumbers;

    AssignedToOffice({
        this.id,
        this.name,
        this.address,
        this.emailIds,
        this.phoneNumbers,
    });

    factory AssignedToOffice.fromJson(Map<String, dynamic> json) => AssignedToOffice(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        emailIds: json["email_ids"],
        phoneNumbers: json["phone_numbers"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "email_ids": emailIds,
        "phone_numbers": phoneNumbers,
    };
}

class Links {
    String? first;
    String? last;
    dynamic prev;
    String? next;

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
