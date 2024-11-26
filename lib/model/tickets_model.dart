class TicketsModelResponse {
  String? message;
  List<TicketModel>? tickets;

  TicketsModelResponse({this.message, this.tickets});

  TicketsModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['tickets'] != null) {
      tickets = <TicketModel>[];
      json['tickets'].forEach((v) {
        tickets!.add(TicketModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketModel {
  CreatedBy? createdBy;
  String? id;
  String? title;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TicketModel(
      {this.createdBy,
      this.id,
      this.title,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  TicketModel.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class CreatedBy {
  String? userName;
  String? emailID;
  String? phone;

  CreatedBy({this.userName, this.emailID, this.phone});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    emailID = json['emailID'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['emailID'] = emailID;
    data['phone'] = phone;
    return data;
  }
}
