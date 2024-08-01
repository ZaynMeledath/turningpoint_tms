class UserModelResponse {
  String? token;
  UserModel? user;

  UserModelResponse({this.token, this.user});

  UserModelResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserModel {
  String? id;
  String? userName;
  String? department;
  String? emailId;
  String? phone;
  String? role;
  String? password;
  String? reportingTo;
  String? createdStamp;
  String? updatedStamp;

  UserModel({
    this.id,
    this.userName,
    this.department,
    this.emailId,
    this.phone,
    this.role,
    this.password,
    this.reportingTo,
    this.createdStamp,
    this.updatedStamp,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userName = json['userName'];
    department = json['department'];
    emailId = json['emailID'];
    phone = json['phone'];
    role = json['role'];
    password = json['password'];
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
    data['password'] = password;
    data['reportingTo'] = reportingTo;
    data['createdStamp'] = createdStamp;
    data['updatedStamp'] = updatedStamp;
    return data;
  }
}
