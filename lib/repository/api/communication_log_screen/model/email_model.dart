class EmailModel {
  List<EmailData>? data;
  Links? links;
  Meta? meta;

  EmailModel({this.data, this.links, this.meta});

  factory EmailModel.fromJson(Map<String, dynamic> json) {
    return EmailModel(
      data: json['data'] != null
          ? List<EmailData>.from(json['data'].map((x) => EmailData.fromJson(x)))
          : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((x) => x.toJson()).toList(),
      'links': links?.toJson(),
      'meta': meta?.toJson(),
    };
  }
}

class EmailData {
  int? id;
  String? to;
  String? subject;
  String? body;
  String? cc;
  String? type;
  String? from;
  String? fromOriginal;
  String? messageDate;
  CreatedBy? createdBy;
  CreatedBy? lastUpdatedBy;
  String? createdAt;
  String? updatedAt;

  EmailData({
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

  factory EmailData.fromJson(Map<String, dynamic> json) {
    return EmailData(
      id: json['id'],
      to: json['to'],
      subject: json['subject'],
      body: json['body'],
      cc: json['cc'],
      type: json['type'],
      from: json['from'],
      fromOriginal: json['from_original'],
      messageDate: json['message_date'],
      createdBy: json['created_by'] != null ? CreatedBy.fromJson(json['created_by']) : null,
      lastUpdatedBy: json['last_updated_by'] != null ? CreatedBy.fromJson(json['last_updated_by']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'to': to,
      'subject': subject,
      'body': body,
      'cc': cc,
      'type': type,
      'from': from,
      'from_original': fromOriginal,
      'message_date': messageDate,
      'created_by': createdBy?.toJson(),
      'last_updated_by': lastUpdatedBy?.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class CreatedBy {
  int? id;
  String? name;
  String? email;
  String? officeCountry;
  String? phoneNumber;
  Role? role;
  dynamic manager;
  int? hasPermissionToAccessUnallocatedLeads;
  dynamic lead;

  CreatedBy({
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

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      officeCountry: json['office_country'],
      phoneNumber: json['phone_number'],
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
      manager: json['manager'],
      hasPermissionToAccessUnallocatedLeads: json['has_permission_to_access_unallocated_leads'],
      lead: json['lead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'office_country': officeCountry,
      'phone_number': phoneNumber,
      'role': role?.toJson(),
      'manager': manager,
      'has_permission_to_access_unallocated_leads': hasPermissionToAccessUnallocatedLeads,
      'lead': lead,
    };
  }
}

class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
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

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      links: json['links'] != null
          ? List<Link>.from(json['links'].map((x) => Link.fromJson(x)))
          : null,
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'links': links?.map((x) => x.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({this.url, this.label, this.active});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
