// To parse this JSON data, do
//
//     final leadsModel = leadsModelFromJson(jsonString);

import 'dart:convert';

LeadsModel leadsModelFromJson(String str) => LeadsModel.fromJson(json.decode(str));

String leadsModelToJson(LeadsModel data) => json.encode(data.toJson());

class LeadsModel {
    List<Datum>? data;
    Links? links;
    Meta? meta;

    LeadsModel({
        this.data,
        this.links,
        this.meta,
    });

    factory LeadsModel.fromJson(Map<String, dynamic> json) => LeadsModel(
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
    String? leadUniqueId;
    String? leadType;
    String? name;
    String? email;
    String? city;
    int? phoneNumber;
    int? whatsappNumber;
    Stage? stage;
    List<StageHistory>? stageHistory;
    LeadSource? leadSource;
    dynamic agency;
    AssignedToOffice? assignedToOffice;
    AssignedTo? assignedTo;
    String? note;
    int? closed;
    int? completed;
    dynamic dateOfBirth;
    String? address;
    dynamic zipcode;
    dynamic state;
    dynamic archiveNote;
    dynamic archiveReason;
    dynamic campaign;
    dynamic event;
    AssignedTo? createdBy;
    AssignedTo? lastUpdatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    Datum({
        this.id,
        this.leadUniqueId,
        this.leadType,
        this.name,
        this.email,
        this.city,
        this.phoneNumber,
        this.whatsappNumber,
        this.stage,
        this.stageHistory,
        this.leadSource,
        this.agency,
        this.assignedToOffice,
        this.assignedTo,
        this.note,
        this.closed,
        this.completed,
        this.dateOfBirth,
        this.address,
        this.zipcode,
        this.state,
        this.archiveNote,
        this.archiveReason,
        this.campaign,
        this.event,
        this.createdBy,
        this.lastUpdatedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        leadUniqueId: json["lead_unique_id"],
        leadType: json["lead_type"],
        name: json["name"],
        email: json["email"],
        city: json["city"],
        phoneNumber: json["phone_number"],
        whatsappNumber: json["whatsapp_number"],
        stage: json["stage"] == null ? null : Stage.fromJson(json["stage"]),
        stageHistory: json["stage_history"] == null ? [] : List<StageHistory>.from(json["stage_history"]!.map((x) => StageHistory.fromJson(x))),
        leadSource: json["lead_source"] == null ? null : LeadSource.fromJson(json["lead_source"]),
        agency: json["agency"],
        assignedToOffice: json["assignedToOffice"] == null ? null : AssignedToOffice.fromJson(json["assignedToOffice"]),
        assignedTo: json["assignedTo"] == null ? null : AssignedTo.fromJson(json["assignedTo"]),
        note: json["note"],
        closed: json["closed"],
        completed: json["completed"],
        dateOfBirth: json["date_of_birth"],
        address: json["address"],
        zipcode: json["zipcode"],
        state: json["state"],
        archiveNote: json["archive_note"],
        archiveReason: json["archive_reason"],
        campaign: json["campaign"],
        event: json["event"],
        createdBy: json["createdBy"] == null ? null : AssignedTo.fromJson(json["createdBy"]),
        lastUpdatedBy: json["lastUpdatedBy"] == null ? null : AssignedTo.fromJson(json["lastUpdatedBy"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lead_unique_id": leadUniqueId,
        "lead_type": leadType,
        "name": name,
        "email": email,
        "city": city,
        "phone_number": phoneNumber,
        "whatsapp_number": whatsappNumber,
        "stage": stage?.toJson(),
        "stage_history": stageHistory == null ? [] : List<dynamic>.from(stageHistory!.map((x) => x.toJson())),
        "lead_source": leadSource?.toJson(),
        "agency": agency,
        "assignedToOffice": assignedToOffice?.toJson(),
        "assignedTo": assignedTo?.toJson(),
        "note": note,
        "closed": closed,
        "completed": completed,
        "date_of_birth": dateOfBirth,
        "address": address,
        "zipcode": zipcode,
        "state": state,
        "archive_note": archiveNote,
        "archive_reason": archiveReason,
        "campaign": campaign,
        "event": event,
        "createdBy": createdBy?.toJson(),
        "lastUpdatedBy": lastUpdatedBy?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}

class AssignedTo {
    int? id;
    String? name;
    String? email;
    OfficeCountry? officeCountry;
    String? phoneNumber;
    LeadSource? role;
    dynamic manager;
    int? hasPermissionToAccessUnallocatedLeads;
    dynamic lead;

    AssignedTo({
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

    factory AssignedTo.fromJson(Map<String, dynamic> json) => AssignedTo(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        officeCountry: json["office_country"] == null ? null : OfficeCountry.fromJson(json["office_country"]),
        phoneNumber: json["phone_number"],
        role: json["role"] == null ? null : LeadSource.fromJson(json["role"]),
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
    String? flag;

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

class LeadSource {
    int? id;
    String? name;

    LeadSource({
        this.id,
        this.name,
    });

    factory LeadSource.fromJson(Map<String, dynamic> json) => LeadSource(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class AssignedToOffice {
    int? id;
    String? name;
    dynamic address;
    dynamic emailIds;
    dynamic phoneNumbers;

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

class Stage {
    int? id;
    String? name;
    String? description;
    dynamic colour;
    String? actionType;
    int? progressPercentage;
    List<dynamic>? subStages;

    Stage({
        this.id,
        this.name,
        this.description,
        this.colour,
        this.actionType,
        this.progressPercentage,
        this.subStages,
    });

    factory Stage.fromJson(Map<String, dynamic> json) => Stage(
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

class StageHistory {
    int? id;
    Stage? stage;

    StageHistory({
        this.id,
        this.stage,
    });

    factory StageHistory.fromJson(Map<String, dynamic> json) => StageHistory(
        id: json["id"],
        stage: json["stage"] == null ? null : Stage.fromJson(json["stage"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "stage": stage?.toJson(),
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
