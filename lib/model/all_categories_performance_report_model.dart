// ignore_for_file: prefer_collection_literals

class AllCategoriesPerformanceReportModelResponse {
  String? message;
  List<AllCategoriesPerformanceReportModel>?
      categoriesPerformanceReportModelList;

  AllCategoriesPerformanceReportModelResponse(
      {this.message, this.categoriesPerformanceReportModelList});

  AllCategoriesPerformanceReportModelResponse.fromJson(
      Map<String, dynamic> json) {
    message = json['message'];
    if (json['categoryStats'] != null) {
      categoriesPerformanceReportModelList =
          <AllCategoriesPerformanceReportModel>[];
      json['categoryStats'].forEach((v) {
        categoriesPerformanceReportModelList!
            .add(AllCategoriesPerformanceReportModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (categoriesPerformanceReportModelList != null) {
      data['categoryStats'] =
          categoriesPerformanceReportModelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCategoriesPerformanceReportModel {
  String? category;
  int? totalTasks;
  int? completedTasks;
  int? openTasks;
  int? inProgressTasks;
  int? overdueTasks;
  int? onTimeTasks;
  int? delayedTasks;
  int? completionRate;
  int? delayedRate;

  AllCategoriesPerformanceReportModel({
    this.category,
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

  AllCategoriesPerformanceReportModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category'] = category;
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
