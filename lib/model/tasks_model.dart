class TasksModelResponse {
  String? message;
  List<TaskModel>? tasks;

  TasksModelResponse({this.message, this.tasks});

  TasksModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['tasks'] != null) {
      tasks = <TaskModel>[];
      json['tasks'].forEach((v) {
        tasks!.add(TaskModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['message'] = message;
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskModel {
  Reminder? reminder;
  String? id;
  String? title;
  String? description;
  String? category;
  String? createdBy;
  String? currentUser;
  List<dynamic>? assignedTo;
  String? priority;
  String? dueDate;
  String? status;
  List<dynamic>? attachments;
  bool? isDelayed;
  String? closedAt;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? statusChanges;

  TaskModel({
    this.reminder,
    this.id,
    this.title,
    this.description,
    this.category,
    this.createdBy,
    this.currentUser,
    this.assignedTo,
    this.priority,
    this.dueDate,
    this.status,
    this.attachments,
    this.isDelayed,
    this.closedAt,
    this.createdAt,
    this.updatedAt,
    this.statusChanges,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    reminder =
        json['reminder'] != null ? Reminder.fromJson(json['reminder']) : null;
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    createdBy = json['createdBy'];
    currentUser = json['currentUser'];
    assignedTo = json['assignTo'];
    priority = json['priority'];
    dueDate = json['dueDate'];
    status = json['status'];
    // if (json['attachments'] != null) {
    //   attachments = [];
    //   json['attachments'].forEach((item) {
    //     attachments!.add(item);
    //   });
    // }
    attachments = json['attachments'];
    isDelayed = json['isDelayed'];
    closedAt = json['closedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // if (json['statusChanges'] != null) {
    //   statusChanges = [];
    //   json['statusChanges'].forEach((v) {
    //     statusChanges!.add(v);
    //   });
    // }
    statusChanges = json['statusChanges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reminder != null) {
      data['reminder'] = reminder!.toJson();
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
    // if (attachments != null) {
    //   data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    // }
    data['attachments'] = attachments;
    data['isDelayed'] = isDelayed;
    data['closedAt'] = closedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    // if (statusChanges != null) {
    //   data['statusChanges'] = statusChanges!.map((v) => v.toJson()).toList();
    // }
    data['statusChanges'] = statusChanges;
    return data;
  }
}

class Reminder {
  String? frequency;
  String? startDate;

  Reminder({
    this.frequency,
    this.startDate,
  });

  Reminder.fromJson(Map<String, dynamic> json) {
    frequency = json['frequency'];
    startDate = json['startDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['frequency'] = frequency;
    data['startDate'] = startDate;
    return data;
  }
}
