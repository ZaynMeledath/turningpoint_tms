class MyPerformanceReportModelResponse {
  String? message;
  List<MyPerformanceReportModel>? myPerformanceModelList;

  MyPerformanceReportModelResponse({this.message, this.myPerformanceModelList});

  MyPerformanceReportModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['report'] != null) {
      myPerformanceModelList = <MyPerformanceReportModel>[];
      json['report'].forEach((v) {
        myPerformanceModelList!.add(MyPerformanceReportModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (myPerformanceModelList != null) {
      data['report'] = myPerformanceModelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyPerformanceReportModel {
  String? category;
  Stats? stats;

  MyPerformanceReportModel({this.category, this.stats});

  MyPerformanceReportModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
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
