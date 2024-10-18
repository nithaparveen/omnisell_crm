class TaskModel {
    TaskModel({
         this.data,
         this.links,
         this.meta,
    });

    final List<Datum>? data;
    final Links? links;
    final Meta? meta;

    factory TaskModel.fromJson(Map<String, dynamic> json){ 
        return TaskModel(
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            links: json["links"] == null ? null : Links.fromJson(json["links"]),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.title,
        required this.description,
        required this.startDate,
        required this.endDate,
        required this.dueDate,
        required this.assignedToUser,
        required this.lead,
        required this.assignedByUser,
        required this.reviewer,
        required this.priority,
        required this.status,
        required this.statusNote,
        required this.archived,
        required this.createdBy,
        required this.lastUpdatedBy,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? title;
    final String? description;
    final dynamic startDate;
    final dynamic endDate;
    final DateTime? dueDate;
    final AssignedByUser? assignedToUser;
    final Lead? lead;
    final AssignedByUser? assignedByUser;
    final dynamic reviewer;
    final String? priority;
    final String? status;
    final dynamic statusNote;
    final int? archived;
    final AssignedByUser? createdBy;
    final AssignedByUser? lastUpdatedBy;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            startDate: json["start_date"],
            endDate: json["end_date"],
            dueDate: DateTime.tryParse(json["due_date"] ?? ""),
            assignedToUser: json["assignedToUser"] == null ? null : AssignedByUser.fromJson(json["assignedToUser"]),
            lead: json["lead"] == null ? null : Lead.fromJson(json["lead"]),
            assignedByUser: json["assignedByUser"] == null ? null : AssignedByUser.fromJson(json["assignedByUser"]),
            reviewer: json["reviewer"],
            priority: json["priority"],
            status: json["status"],
            statusNote: json["status_note"],
            archived: json["archived"],
            createdBy: json["createdBy"] == null ? null : AssignedByUser.fromJson(json["createdBy"]),
            lastUpdatedBy: json["lastUpdatedBy"] == null ? null : AssignedByUser.fromJson(json["lastUpdatedBy"]),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}

class AssignedByUser {
    AssignedByUser({
        required this.id,
        required this.name,
        required this.email,
        required this.officeCountry,
        required this.phoneNumber,
        required this.role,
        required this.manager,
        required this.hasPermissionToAccessUnallocatedLeads,
        required this.lead,
    });

    final int? id;
    final String? name;
    final String? email;
    final dynamic officeCountry;
    final String? phoneNumber;
    final Role? role;
    final dynamic manager;
    final int? hasPermissionToAccessUnallocatedLeads;
    final dynamic lead;

    factory AssignedByUser.fromJson(Map<String, dynamic> json){ 
        return AssignedByUser(
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
    }

}

class Role {
    Role({
        required this.id,
        required this.name,
    });

    final int? id;
    final String? name;

    factory Role.fromJson(Map<String, dynamic> json){ 
        return Role(
            id: json["id"],
            name: json["name"],
        );
    }

}

class Lead {
    Lead({
        required this.id,
        required this.leadUniqueId,
        required this.leadType,
        required this.title,
        required this.name,
        required this.email,
        required this.city,
        required this.dateOfBirth,
        required this.phoneCountryCode,
        required this.phoneNumber,
        required this.alternatePhoneCountryCode,
        required this.alternatePhoneNumber,
        required this.whatsappCountryCode,
        required this.whatsappNumber,
        required this.studentCode,
        required this.assignedToOffice,
        required this.assignedToCounsellor,
        required this.assignedToApplicationManager,
        required this.closed,
    });

    final int? id;
    final String? leadUniqueId;
    final String? leadType;
    final dynamic title;
    final String? name;
    final String? email;
    final String? city;
    final dynamic dateOfBirth;
    final dynamic phoneCountryCode;
    final int? phoneNumber;
    final dynamic alternatePhoneCountryCode;
    final dynamic alternatePhoneNumber;
    final dynamic whatsappCountryCode;
    final int? whatsappNumber;
    final dynamic studentCode;
    final AssignedToOffice? assignedToOffice;
    final dynamic assignedToCounsellor;
    final dynamic assignedToApplicationManager;
    final int? closed;

    factory Lead.fromJson(Map<String, dynamic> json){ 
        return Lead(
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
    }

}

class AssignedToOffice {
    AssignedToOffice({
        required this.id,
        required this.name,
        required this.address,
        required this.emailIds,
        required this.phoneNumbers,
    });

    final int? id;
    final String? name;
    final String? address;
    final String? emailIds;
    final String? phoneNumbers;

    factory AssignedToOffice.fromJson(Map<String, dynamic> json){ 
        return AssignedToOffice(
            id: json["id"],
            name: json["name"],
            address: json["address"],
            emailIds: json["email_ids"],
            phoneNumbers: json["phone_numbers"],
        );
    }

}

class Links {
    Links({
        required this.first,
        required this.last,
        required this.prev,
        required this.next,
    });

    final String? first;
    final String? last;
    final dynamic prev;
    final dynamic next;

    factory Links.fromJson(Map<String, dynamic> json){ 
        return Links(
            first: json["first"],
            last: json["last"],
            prev: json["prev"],
            next: json["next"],
        );
    }

}

class Meta {
    Meta({
        required this.currentPage,
        required this.from,
        required this.lastPage,
        required this.links,
        required this.path,
        required this.perPage,
        required this.to,
        required this.total,
    });

    final int? currentPage;
    final int? from;
    final int? lastPage;
    final List<Link> links;
    final String? path;
    final int? perPage;
    final int? to;
    final int? total;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            currentPage: json["current_page"],
            from: json["from"],
            lastPage: json["last_page"],
            links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
            path: json["path"],
            perPage: json["per_page"],
            to: json["to"],
            total: json["total"],
        );
    }

}

class Link {
    Link({
        required this.url,
        required this.label,
        required this.active,
    });

    final String? url;
    final String? label;
    final bool? active;

    factory Link.fromJson(Map<String, dynamic> json){ 
        return Link(
            url: json["url"],
            label: json["label"],
            active: json["active"],
        );
    }

}
