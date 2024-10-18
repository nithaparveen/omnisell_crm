import 'dart:convert';

// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  List<Datum>? data;
  Links? links;
  Meta? meta;

  PaymentModel({
    this.data,
    this.links,
    this.meta,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
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
  Lead? lead;
  String? amount;
  String? paymentMode;
  DateTime? paymentDate;
  String? details;
  String? receiptFile;
  AtedBy? createdBy;
  AtedBy? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.lead,
    this.amount,
    this.paymentMode,
    this.paymentDate,
    this.details,
    this.receiptFile,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        lead: json["lead"] == null ? null : Lead.fromJson(json["lead"]),
        amount: json["amount"],
        paymentMode: json["payment_mode"],
        paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
        details: json["details"],
        receiptFile: json["receipt_file"],
        createdBy: json["created_by"] == null ? null : AtedBy.fromJson(json["created_by"]),
        updatedBy: json["updated_by"] == null ? null : AtedBy.fromJson(json["updated_by"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lead": lead?.toJson(),
        "amount": amount,
        "payment_mode": paymentMode,
        "payment_date": paymentDate?.toIso8601String(),
        "details": details,
        "receipt_file": receiptFile,
        "created_by": createdBy?.toJson(),
        "updated_by": updatedBy?.toJson(),
        "created_at": createdAt?.toIso8601String(),
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
        name: json["name"],
        email: json["email"],
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

class Lead {
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
  Role? leadSource;
  dynamic agency;
  dynamic assignedToOffice;
  dynamic assignedTo;
  dynamic note;
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
  AtedBy? createdBy;
  AtedBy? lastUpdatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Lead({
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

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        id: json["id"],
        leadUniqueId: json["lead_unique_id"],
        leadType: json["lead_type"],
        name: json["name"],
        email: json["email"],
        city: json["city"],
        phoneNumber: json["phone_number"],
        whatsappNumber: json["whatsapp_number"],
        stage: json["stage"] == null ? null : Stage.fromJson(json["stage"]),
        stageHistory: json["stage_history"] == null
            ? []
            : List<StageHistory>.from(json["stage_history"]!.map((x) => StageHistory.fromJson(x))),
        leadSource: json["lead_source"] == null ? null : Role.fromJson(json["lead_source"]),
        agency: json["agency"],
        assignedToOffice: json["assignedToOffice"],
        assignedTo: json["assignedTo"],
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
        createdBy: json["createdBy"] == null ? null : AtedBy.fromJson(json["createdBy"]),
        lastUpdatedBy: json["lastUpdatedBy"] == null ? null : AtedBy.fromJson(json["lastUpdatedBy"]),
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
        "assignedToOffice": assignedToOffice,
        "assignedTo": assignedTo,
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

class Stage {
  int? id;
  String? name;
  String? description;
  String? colour;
  String? actionType;
  int? progressPercentage;
  dynamic subStages;

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
        subStages: json["sub_stages"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "colour": colour,
        "action_type": actionType,
        "progress_percentage": progressPercentage,
        "sub_stages": subStages,
      };
}

class StageHistory {
  int? id;
  Stage? fromStage;
  Stage? toStage;
  DateTime? createdAt;

  StageHistory({
    this.id,
    this.fromStage,
    this.toStage,
    this.createdAt,
  });

  factory StageHistory.fromJson(Map<String, dynamic> json) => StageHistory(
        id: json["id"],
        fromStage: json["from_stage"] == null ? null : Stage.fromJson(json["from_stage"]),
        toStage: json["to_stage"] == null ? null : Stage.fromJson(json["to_stage"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_stage": fromStage?.toJson(),
        "to_stage": toStage?.toJson(),
        "created_at": createdAt?.toIso8601String(),
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
