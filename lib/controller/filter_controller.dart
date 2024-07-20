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

  final RxMap<String, bool> usersFilterModel = {
    for (String element in assignedMap.values) element.toString(): false
  }.obs;

  final RxMap<String, bool> frequencyFilterModel =
      {for (String element in frequencyList) element.toString(): false}.obs;

  final RxMap<String, bool> priorityFilterModel =
      {for (String element in priorityList) element.toString(): false}.obs;

  final RxList selectedCategoryList = [].obs;
  final RxList selectedUsersList = [].obs;
  final RxList selectedFrequencyList = [].obs;
  final RxList selectedPriorityList = [].obs;

//====================Select or Unselect Category Filters====================//
  void selectOrUnselectCategoryFilter({
    required String filterKey,
  }) {
    categoryFilterModel[filterKey] = !categoryFilterModel[filterKey]!;

    if (categoryFilterModel[filterKey] == true) {
      selectedCategoryList.add(filterKey);
    } else {
      selectedCategoryList.remove(filterKey);
    }
  }

//====================Select or Unselect Assigned Filters====================//
  void selectOrUnselectUsersFilter({
    required String filterKey,
  }) {
    usersFilterModel[filterKey] = !usersFilterModel[filterKey]!;

    if (usersFilterModel[filterKey] == true) {
      selectedUsersList.add(filterKey);
    } else {
      selectedUsersList.remove(filterKey);
    }
  }

//====================Select or Unselect Frequency Filters====================//
  void selectOrUnselectFrequencyFilter({
    required String filterKey,
  }) {
    frequencyFilterModel[filterKey] = !frequencyFilterModel[filterKey]!;

    if (frequencyFilterModel[filterKey] == true) {
      selectedFrequencyList.add(filterKey);
    } else {
      selectedFrequencyList.remove(filterKey);
    }
  }

//====================Select or Unselect Filters====================//
  void selectOrUnselectPriorityFilter({
    required String filterKey,
  }) {
    priorityFilterModel[filterKey] = !priorityFilterModel[filterKey]!;

    if (priorityFilterModel[filterKey] == true) {
      selectedPriorityList.add(filterKey);
    } else {
      selectedPriorityList.remove(filterKey);
    }
  }
}
