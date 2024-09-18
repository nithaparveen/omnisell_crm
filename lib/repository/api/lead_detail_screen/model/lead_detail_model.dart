// To parse this JSON data, do
//
//     final leadDetailsModel = leadDetailsModelFromJson(jsonString);

import 'dart:convert';

LeadDetailsModel leadDetailsModelFromJson(String str) => LeadDetailsModel.fromJson(json.decode(str));

String leadDetailsModelToJson(LeadDetailsModel data) => json.encode(data.toJson());

class LeadDetailsModel {
    Data? data;

    LeadDetailsModel({
        this.data,
    });

    factory LeadDetailsModel.fromJson(Map<String, dynamic> json) => LeadDetailsModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
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
    dynamic note;
    int? closed;
    int? completed;
    dynamic dateOfBirth;
    dynamic address;
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
    LatestTask? latestTask;
    LatestFollowUp? latestFollowUp;

    Data({
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
        this.latestTask,
        this.latestFollowUp,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        latestTask: json["latest_task"] == null ? null : LatestTask.fromJson(json["latest_task"]),
        latestFollowUp: json["latest_follow_up"] == null ? null : LatestFollowUp.fromJson(json["latest_follow_up"]),
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
        "latest_task": latestTask?.toJson(),
        "latest_follow_up": latestFollowUp?.toJson(),
    };
}

class AssignedTo {
    int? id;
    Name? name;
    Email? email;
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
        name: nameValues.map[json["name"]]!,
        email: emailValues.map[json["email"]]!,
        officeCountry: json["office_country"] == null ? null : OfficeCountry.fromJson(json["office_country"]),
        phoneNumber: json["phone_number"],
        role: json["role"] == null ? null : LeadSource.fromJson(json["role"]),
        manager: json["manager"],
        hasPermissionToAccessUnallocatedLeads: json["has_permission_to_access_unallocated_leads"],
        lead: json["lead"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "email": emailValues.reverse[email],
        "office_country": officeCountry?.toJson(),
        "phone_number": phoneNumber,
        "role": role?.toJson(),
        "manager": manager,
        "has_permission_to_access_unallocated_leads": hasPermissionToAccessUnallocatedLeads,
        "lead": lead,
    };
}

enum Email {
    MANAGER_FASTTRACKRAK_COM,
    SALESRAK_FASTTRACKRAK_COM,
    SUPER_ADMIN_SPIDERWORKS_IN
}

final emailValues = EnumValues({
    "manager@fasttrackrak.com": Email.MANAGER_FASTTRACKRAK_COM,
    "salesrak@fasttrackrak.com": Email.SALESRAK_FASTTRACKRAK_COM,
    "super.admin@spiderworks.in": Email.SUPER_ADMIN_SPIDERWORKS_IN
});

enum Name {
    RAK_MANAGER,
    RAK_SALES,
    SUPER_ADMIN
}

final nameValues = EnumValues({
    "RAK Manager": Name.RAK_MANAGER,
    "RAK Sales": Name.RAK_SALES,
    "Super Admin": Name.SUPER_ADMIN
});

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

class LatestFollowUp {
    int? id;
    String? type;
    DateTime? followUpDate;
    AssignedTo? assignedToUser;
    String? note;
    String? status;
    AssignedTo? createdBy;
    AssignedTo? lastUpdatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    LatestFollowUp({
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

    factory LatestFollowUp.fromJson(Map<String, dynamic> json) => LatestFollowUp(
        id: json["id"],
        type: json["type"],
        followUpDate: json["follow_up_date"] == null ? null : DateTime.parse(json["follow_up_date"]),
        assignedToUser: json["assigned_to_user"] == null ? null : AssignedTo.fromJson(json["assigned_to_user"]),
        note: json["note"],
        status: json["status"],
        createdBy: json["created_by"] == null ? null : AssignedTo.fromJson(json["created_by"]),
        lastUpdatedBy: json["last_updated_by"] == null ? null : AssignedTo.fromJson(json["last_updated_by"]),
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

class LatestTask {
    int? id;
    String? title;
    dynamic description;
    dynamic startDate;
    dynamic endDate;
    DateTime? dueDate;
    AssignedTo? assignedToUser;
    Lead? lead;
    AssignedTo? assignedByUser;
    dynamic reviewer;
    String? priority;
    String? status;
    dynamic statusNote;
    int? archived;
    AssignedTo? createdBy;
    AssignedTo? lastUpdatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    LatestTask({
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

    factory LatestTask.fromJson(Map<String, dynamic> json) => LatestTask(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        assignedToUser: json["assignedToUser"] == null ? null : AssignedTo.fromJson(json["assignedToUser"]),
        lead: json["lead"] == null ? null : Lead.fromJson(json["lead"]),
        assignedByUser: json["assignedByUser"] == null ? null : AssignedTo.fromJson(json["assignedByUser"]),
        reviewer: json["reviewer"],
        priority: json["priority"],
        status: json["status"],
        statusNote: json["status_note"],
        archived: json["archived"],
        createdBy: json["createdBy"] == null ? null : AssignedTo.fromJson(json["createdBy"]),
        lastUpdatedBy: json["lastUpdatedBy"] == null ? null : AssignedTo.fromJson(json["lastUpdatedBy"]),
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

class Stage {
    int? id;
    String? name;
    String? description;
    String? colour;
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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
