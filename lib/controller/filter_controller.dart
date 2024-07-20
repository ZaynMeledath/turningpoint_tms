import 'package:get/get.dart';

final categoriesList = [
  'Marketing',
  'Sales',
  'HR/Admin',
];

final assignedMap = {
  'Zayn': 'zayn@turningpointvapi.com',
  'Ajay': 'ajay@turningpointvapi.com',
  'Tanya': 'tanya@turningpointvapi.com',
};

final priorityList = ['High', 'Medium', 'Low'];

final frequencyList = ['Once', 'Daily', 'Weekly', 'Monthly'];

class FilterController extends GetxController {
  final RxMap<String, bool> categoryFilterModel =
      {for (String element in categoriesList) element.toString(): false}.obs;

  final RxMap<String, bool> assignedFilterModel = {
    for (String element in assignedMap.values) element.toString(): false
  }.obs;

  final RxMap<String, bool> frequencyFilterModel =
      {for (String element in frequencyList) element.toString(): false}.obs;

  final RxMap<String, bool> priorityFilterModel =
      {for (String element in priorityList) element.toString(): false}.obs;

//====================Select or Unselect Category Filters====================//
  void selectOrUnselectCategoryFilter({
    required String filterKey,
  }) {
    categoryFilterModel[filterKey] = !categoryFilterModel[filterKey]!;
  }

//====================Select or Unselect Assigned Filters====================//
  void selectOrUnselectAssignedFilter({
    required String filterKey,
  }) {
    assignedFilterModel[filterKey] = !assignedFilterModel[filterKey]!;
  }

//====================Select or Unselect Frequency Filters====================//
  void selectOrUnselectFrequencyFilter({
    required String filterKey,
  }) {
    frequencyFilterModel[filterKey] = !frequencyFilterModel[filterKey]!;
  }

//====================Select or Unselect Filters====================//
  void selectOrUnselectPriorityFilter({
    required String filterKey,
  }) {
    priorityFilterModel[filterKey] = !priorityFilterModel[filterKey]!;
  }
}
