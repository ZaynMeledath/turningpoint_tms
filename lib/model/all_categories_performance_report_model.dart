// ignore_for_file: prefer_collection_literals

class AllCategoriesPerformanceReportModelResponse {
  List<AllCategoriesPerformanceReportModel>?
      categoriesPerformanceReportModelList;

  AllCategoriesPerformanceReportModelResponse(
      {this.categoriesPerformanceReportModelList});

  AllCategoriesPerformanceReportModelResponse.fromJson(List<dynamic>? json) {
    if (json != null) {
      categoriesPerformanceReportModelList =
          <AllCategoriesPerformanceReportModel>[];
      for (var item in json) {
        categoriesPerformanceReportModelList!
            .add(AllCategoriesPerformanceReportModel.fromJson(item));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoriesPerformanceReportModelList != null) {
      data['tasks'] = categoriesPerformanceReportModelList!
          .map((item) => item.toJson())
          .toList();
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
    return data;
  }
}
