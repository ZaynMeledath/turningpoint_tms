class DelegatedPerformanceReportModelResponse {
  String? message;
  List<DelegatedPerformanceReportModel>? delegatedPerformanceReportModelList;

  DelegatedPerformanceReportModelResponse(
      {this.message, this.delegatedPerformanceReportModelList});

  DelegatedPerformanceReportModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['performance'] != null) {
      delegatedPerformanceReportModelList = <DelegatedPerformanceReportModel>[];
      json['performance'].forEach((v) {
        delegatedPerformanceReportModelList!
            .add(DelegatedPerformanceReportModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (delegatedPerformanceReportModelList != null) {
      data['performance'] =
          delegatedPerformanceReportModelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DelegatedPerformanceReportModel {
  String? userName;
  Stats? stats;

  DelegatedPerformanceReportModel({this.userName, this.stats});

  DelegatedPerformanceReportModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
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

  Stats({
    this.totalTasks,
    this.completedTasks,
    this.openTasks,
    this.inProgressTasks,
    this.overdueTasks,
    this.onTimeTasks,
    this.delayedTasks,
    this.completionRate,
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
    return data;
  }
}
