// ignore_for_file: prefer_collection_literals

class AllUsersPerformanceReportModelResponse {
  String? message;
  List<AllUsersPerformanceReportModel>? usersPerformanceModelList;

  AllUsersPerformanceReportModelResponse(
      {this.message, this.usersPerformanceModelList});

  AllUsersPerformanceReportModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['usersPerformance'] != null) {
      usersPerformanceModelList = <AllUsersPerformanceReportModel>[];
      json['usersPerformance'].forEach((v) {
        usersPerformanceModelList!
            .add(AllUsersPerformanceReportModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (usersPerformanceModelList != null) {
      data['usersPerformance'] =
          usersPerformanceModelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllUsersPerformanceReportModel {
  String? userName;
  String? emailId;
  String? profileImg;
  String? role;
  Stats? stats;

  AllUsersPerformanceReportModel({
    this.userName,
    this.emailId,
    this.profileImg,
    this.role,
    this.stats,
  });

  AllUsersPerformanceReportModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    emailId = json['emailID'];
    profileImg = json['profileImg'];
    role = json['role'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['emailID'] = emailId;
    data['profileImg'] = profileImg;
    data['role'] = role;
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }

    return data;
  }
}

class Stats {
  int? totalTasks;
  int? completedTasks;
  int? openTasks;
  int? inProgressTasks;
  int? overdueTasks;
  int? onTimeTasks;
  int? delayedTasks;
  int? completionRate;
  int? delayedRate;

  Stats({
    this.totalTasks,
    this.completedTasks,
    this.openTasks,
    this.inProgressTasks,
    this.overdueTasks,
    this.onTimeTasks,
    this.delayedTasks,
    this.completionRate,
    this.delayedRate,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    totalTasks = json['totalTasks'];
    completedTasks = json['completedTasks'];
    openTasks = json['openTasks'];
    inProgressTasks = json['inProgressTasks'];
    overdueTasks = json['overdueTasks'];
    onTimeTasks = json['onTimeTasks'];
    delayedTasks = json['delayedTasks'];
    completionRate = json['completionRate'];
    delayedRate = json['delayedRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalTasks'] = totalTasks;
    data['completedTasks'] = completedTasks;
    data['openTasks'] = openTasks;
    data['inProgressTasks'] = inProgressTasks;
    data['overdueTasks'] = overdueTasks;
    data['onTimeTasks'] = onTimeTasks;
    data['delayedTasks'] = delayedTasks;
    data['completionRate'] = completionRate;
    data['delayedRate'] = delayedRate;
    return data;
  }
}
