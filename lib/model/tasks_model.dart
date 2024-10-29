// ignore_for_file: prefer_collection_literals

class TasksModelResponse {
  String? message;
  List<TaskModel>? tasks;

  TasksModelResponse({this.message, this.tasks});

  TasksModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['tasks'] != null) {
      tasks = <TaskModel>[];
      json['tasks'].forEach((item) {
        tasks!.add(TaskModel.fromJson(item));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['message'] = message;
    if (tasks != null) {
      data['tasks'] = tasks!.map((item) => item.toJson()).toList();
    }
    return data;
  }
}

class TaskModel {
  String? id;
  String? title;
  String? description;
  String? category;
  CreatedBy? createdBy;
  List<AssignedTo>? assignedTo;
  String? currentUser;
  String? priority;
  String? dueDate;
  String? status;
  bool? isDelayed;
  Repeat? repeat;
  List<Attachment>? attachments;
  List<Reminder>? reminders;
  List<StatusChanges>? statusChanges;
  String? closedAt;
  String? createdAt;
  String? updatedAt;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.createdBy,
    this.assignedTo,
    this.currentUser,
    this.priority,
    this.dueDate,
    this.status,
    this.isDelayed,
    this.repeat,
    this.attachments,
    this.reminders,
    this.statusChanges,
    this.closedAt,
    this.createdAt,
    this.updatedAt,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    if (json['reminders'] != null) {
      reminders = [];
      json['reminders']
          .forEach((item) => reminders!.add(Reminder.fromJson(item)));
    }

    id = json['_id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    createdBy = CreatedBy.fromJson(json['createdBy']);
    currentUser = json['currentUser'];
    if (json['assignTo'] != null) {
      assignedTo = <AssignedTo>[];
      json['assignTo'].forEach((item) {
        assignedTo!.add(AssignedTo.fromJson(item));
      });
    }
    priority = json['priority'];
    dueDate = json['dueDate'];
    status = json['status'];
    if (json['attachments'] != null) {
      attachments = [];
      json['attachments'].forEach((item) {
        attachments!.add(Attachment.fromJson(item));
      });
    }

    repeat = json['repeat'] != null ? Repeat.fromJson(json) : null;
    isDelayed = json['isDelayed'];
    closedAt = json['closedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['statusChanges'] != null) {
      statusChanges = [];
      json['statusChanges'].forEach((item) {
        statusChanges!.add(StatusChanges.fromJson(item));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (reminders != null) {
      data['reminders'] = reminders!.map((item) => item.toJson()).toList();
    }
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['createdBy'] = createdBy;
    data['currentUser'] = currentUser;
    data['assignTo'] = assignedTo;
    data['priority'] = priority;
    data['dueDate'] = dueDate;
    data['status'] = status;
    if (attachments != null) {
      data['attachments'] = attachments!.map((item) => item.toJson()).toList();
    }
    data['attachments'] = attachments;
    data['repeat'] = repeat?.toJson();
    data['isDelayed'] = isDelayed;
    data['closedAt'] = closedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (statusChanges != null) {
      data['statusChanges'] =
          statusChanges!.map((item) => item.toJson()).toList();
    }
    data['statusChanges'] = statusChanges;
    return data;
  }

// Overriding the == operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.createdBy == createdBy &&
        other.assignedTo == assignedTo &&
        other.currentUser == currentUser &&
        other.priority == priority &&
        other.dueDate == dueDate &&
        other.status == status &&
        other.isDelayed == isDelayed &&
        other.repeat == repeat &&
        other.attachments == attachments &&
        other.reminders == reminders &&
        other.statusChanges == statusChanges &&
        other.closedAt == closedAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  // Overriding the hashCode method
  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        createdBy.hashCode ^
        assignedTo.hashCode ^
        currentUser.hashCode ^
        priority.hashCode ^
        dueDate.hashCode ^
        status.hashCode ^
        isDelayed.hashCode ^
        repeat.hashCode ^
        attachments.hashCode ^
        reminders.hashCode ^
        statusChanges.hashCode ^
        closedAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class AssignedTo {
  String? name;
  String? emailId;
  String? phone;

  AssignedTo({
    this.name,
    this.emailId,
    this.phone,
  });

  AssignedTo.fromJson(Map<String, dynamic> json) {
    name = json['userName'];
    emailId = json['emailID'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userName'] = name;
    data['emailID'] = emailId;
    data['phone'] = phone;
    return data;
  }
}

class CreatedBy {
  String? name;
  String? emailId;
  String? phone;

  CreatedBy({
    this.name,
    this.emailId,
    this.phone,
  });

  CreatedBy.fromJson(Map<String, dynamic> json) {
    name = json['userName'];
    emailId = json['emailID'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userName'] = name;
    data['emailID'] = emailId;
    data['phone'] = phone;
    return data;
  }
}

class Reminder {
  int? time;
  String? unit;

  Reminder({
    this.time,
    this.unit,
  });

  @override
  bool operator ==(other) =>
      other is Reminder && other.time == time && other.unit == unit;

  @override
  int get hashCode => time.hashCode ^ unit.hashCode;

  Reminder.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['unit'] = unit;
    return data;
  }
}

class Attachment {
  String? path;
  String? type;

  Attachment({
    this.path,
    this.type,
  });

  Attachment.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['path'] = path;
    data['type'] = type;

    return data;
  }
}

class StatusChanges {
  String? id;
  String? status;
  String? note;
  String? taskUpdatedBy;
  List<Attachment>? changesAttachments;
  String? changedAt;

  StatusChanges({
    this.id,
    this.status,
    this.note,
    this.taskUpdatedBy,
    this.changesAttachments,
    this.changedAt,
  });

  StatusChanges.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    status = json['status'];
    note = json['note'];
    taskUpdatedBy = json['taskUpdatedBy'];
    if (json['changesAttachments'] != null) {
      changesAttachments = [];
      json['changesAttachments'].forEach((item) {
        changesAttachments!.add(Attachment.fromJson(item));
      });
    }
    changedAt = json['changedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['status'] = status;
    data['note'] = note;
    data['taskUpdatedBy'] = taskUpdatedBy;
    if (changesAttachments != null) {
      data['changesAttachments'] =
          changesAttachments!.map((item) => item.toJson()).toList();
    }
    data['changedAt'] = changedAt;
    return data;
  }
}

class Repeat {
  String? frequency;
  List<int>? days;
  String? startDate;

  Repeat({this.frequency, this.days, this.startDate});

  Repeat.fromJson(Map<String, dynamic> json) {
    frequency = json['frequency'];
    days = json['days'];
    startDate = json['startDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['frequency'] = frequency;
    data['days'] = days;
    data['startDate'] = startDate;
    return data;
  }
}
