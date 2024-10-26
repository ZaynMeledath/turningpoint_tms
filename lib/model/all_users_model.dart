class AllUsersModelResponse {
  List<AllUsersModel>? users;

  AllUsersModelResponse({this.users});

  AllUsersModelResponse.fromJson(List<dynamic>? json) {
    if (json != null) {
      users = <AllUsersModel>[];
      for (var item in json) {
        users!.add(AllUsersModel.fromJson(item));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['tasks'] = users!.map((item) => item.toJson()).toList();
    }
    return data;
  }
}

class AllUsersModel {
  String? id;
  String? userName;
  String? department;
  String? emailId;
  String? phone;
  String? role;
  bool? isBlocked;
  String? reportingTo;
  String? createdStamp;
  String? updatedStamp;
  String? password;

  AllUsersModel({
    this.id,
    this.userName,
    this.department,
    this.emailId,
    this.phone,
    this.role,
    this.isBlocked,
    this.reportingTo,
    this.createdStamp,
    this.updatedStamp,
    this.password,
  });

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userName = json['userName'];
    department = json['department'];
    emailId = json['emailID'];
    phone = json['phone'];
    role = json['role'];
    isBlocked = json['isBlocked'];
    reportingTo = json['reportingTo'];
    createdStamp = json['createdStamp'];
    updatedStamp = json['updatedStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userName'] = userName;
    data['department'] = department;
    data['emailID'] = emailId;
    data['phone'] = phone;
    data['role'] = role;
    data['isBlocked'] = isBlocked;
    data['reportingTo'] = reportingTo;
    data['createdStamp'] = createdStamp;
    data['updatedStamp'] = updatedStamp;
    data['password'] = password;
    return data;
  }
}
