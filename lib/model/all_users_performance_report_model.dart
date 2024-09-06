class AllUsersPerformanceReportModelResponse {
  List<AllUsersPerformanceReportModel>? usersPerformanceModel;

  AllUsersPerformanceReportModelResponse({this.usersPerformanceModel});

  AllUsersPerformanceReportModelResponse.fromJson(List<dynamic>? json) {
    if (json != null) {
      usersPerformanceModel = <AllUsersPerformanceReportModel>[];
      for (var item in json) {
        usersPerformanceModel!
            .add(AllUsersPerformanceReportModel.fromJson(item));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usersPerformanceModel != null) {
      data['tasks'] =
          usersPerformanceModel!.map((item) => item.toJson()).toList();
    }
    return data;
  }
}

class AllUsersPerformanceReportModel {
  String? userName;
  String? role;
  Stats? stats;

  AllUsersPerformanceReportModel({
    this.userName,
    this.role,
    this.stats,
  });

  AllUsersPerformanceReportModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    role = json['role'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
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
    completionRate = json['completionRate'].toInt();
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

// class CategoryStats {
//   String? category;
//   int? totalTasks;
//   int? completedTasks;
//   int? openTasks;
//   int? inProgressTasks;
//   int? overdueTasks;
//   int? onTimeTasks;
//   int? delayedTasks;
//   int? completionRate;

//   CategoryStats(
//       {this.category,
//       this.totalTasks,
//       this.completedTasks,
//       this.openTasks,
//       this.inProgressTasks,
//       this.overdueTasks,
//       this.onTimeTasks,
//       this.delayedTasks,
//       this.completionRate});

//   CategoryStats.fromJson(Map<String, dynamic> json) {
//     category = json['category'];
//     totalTasks = json['totalTasks'];
//     completedTasks = json['completedTasks'];
//     openTasks = json['openTasks'];
//     inProgressTasks = json['inProgressTasks'];
//     overdueTasks = json['overdueTasks'];
//     onTimeTasks = json['onTimeTasks'];
//     delayedTasks = json['delayedTasks'];
//     completionRate = json['completionRate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['category'] = category;
//     data['totalTasks'] = totalTasks;
//     data['completedTasks'] = completedTasks;
//     data['openTasks'] = openTasks;
//     data['inProgressTasks'] = inProgressTasks;
//     data['overdueTasks'] = overdueTasks;
//     data['onTimeTasks'] = onTimeTasks;
//     data['delayedTasks'] = delayedTasks;
//     data['completionRate'] = completionRate;
//     return data;
//   }
// }
