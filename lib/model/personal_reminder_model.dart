class PersonalReminderModelResponse {
  List<PersonalReminderModel>? reminders;

  PersonalReminderModelResponse({this.reminders});

  PersonalReminderModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['reminders'] != null) {
      reminders = <PersonalReminderModel>[];
      json['reminders'].forEach((v) {
        reminders!.add(PersonalReminderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reminders != null) {
      data['reminders'] = reminders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PersonalReminderModel {
  String? id;
  Task? task;
  User? user;
  String? message;
  String? status;
  String? reminderDate;
  String? createdAt;
  int? iV;

  PersonalReminderModel({
    this.id,
    this.task,
    this.user,
    this.message,
    this.status,
    this.reminderDate,
    this.createdAt,
    this.iV,
  });

  PersonalReminderModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    message = json['message'];
    status = json['status'];
    reminderDate = json['reminderDate'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (task != null) {
      data['task'] = task!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    data['reminderDate'] = reminderDate;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}

class Task {
  String? id;
  String? title;

  Task({this.id, this.title});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    return data;
  }
}

class User {
  String? id;
  String? userName;
  String? emailID;
  String? phone;

  User({this.id, this.userName, this.emailID, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userName = json['userName'];
    emailID = json['emailID'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userName'] = userName;
    data['emailID'] = emailID;
    data['phone'] = phone;
    return data;
  }
}
