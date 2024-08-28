import 'package:get/get.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/model/all_users_model.dart';

final priorityList = ['High', 'Medium', 'Low'];

final frequencyList = ['Once', 'Daily', 'Weekly', 'Monthly'];

class FilterOptions {
  static const category = 'category';
  static const assignedBy = 'assignedBy';
  static const assignedTo = 'assignedTo';
  static const frequency = 'frequency';
  static const priority = 'priority';
}

class FilterController extends GetxController {
  final TasksController tasksController = Get.put(TasksController());
  FilterController() {
    assignValuesToModels();
  }

  // RxMap<String, bool> filterOptionSelectedMap = {
  //   'category': true,
  //   'assignedBy': false,
  //   'assignedTo': false,
  //   'frequency': false,
  //   'priority': false,
  // }.obs;

  RxList<String> filterOptionSelectedMap = [
    FilterOptions.category,
    FilterOptions.assignedBy,
    FilterOptions.assignedTo,
    FilterOptions.frequency,
    FilterOptions.priority,
  ].obs;

//Defines the currently selected filter bottom sheet option
  Rx<String> selectedFilterOption = 'category'.obs;

  final RxMap<String, bool> categoryFilterModel = <String, bool>{}.obs;
  final RxMap<String, bool> assignedByFilterModel = <String, bool>{}.obs;
  final RxMap<String, bool> assignedToFilterModel = <String, bool>{}.obs;
  final RxMap<String, bool> frequencyFilterModel = <String, bool>{}.obs;
  final RxMap<String, bool> priorityFilterModel = <String, bool>{}.obs;

  final RxList selectedCategoryList = [].obs;
  final RxList selectedAssignedByList = [].obs;
  final RxList selectedAssignedToList = [].obs;
  final RxList selectedFrequencyList = [].obs;
  final RxList selectedPriorityList = [].obs;

//====================Assign Values to Models====================//
  void assignValuesToModels() {
    final userController = Get.put(UserController());
    categoryFilterModel.value = {
      for (String element in tasksController.categoriesList)
        element.toString(): false
    };

    if (userController.myTeamList.value != null) {
      assignedByFilterModel.value = {
        for (AllUsersModel element in userController.myTeamList.value!)
          element.emailId.toString(): false
      };

      assignedToFilterModel.value = {
        for (AllUsersModel element in userController.myTeamList.value!)
          element.emailId.toString(): false
      };
    }

    frequencyFilterModel.value = {
      for (String element in frequencyList) element.toString(): false
    };

    priorityFilterModel.value = {
      for (String element in priorityList) element.toString(): false
    };
  }

//====================Select Filter====================//
  void selectFilterOption({required String filterOption}) {
    selectedFilterOption.value = filterOption;
  }

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

//====================Select or Unselect Assigned By Filters====================//
  void selectOrUnselectAssignedByFilter({
    required String filterKey,
  }) {
    assignedByFilterModel[filterKey] = !assignedByFilterModel[filterKey]!;

    if (assignedByFilterModel[filterKey] == true) {
      selectedAssignedByList.add(filterKey);
    } else {
      selectedAssignedByList.remove(filterKey);
    }
  }

//====================Select or Unselect Assigned To Filters====================//
  void selectOrUnselectAssignedToFilter({
    required String filterKey,
  }) {
    assignedToFilterModel[filterKey] = !assignedToFilterModel[filterKey]!;

    if (assignedToFilterModel[filterKey] == true) {
      selectedAssignedToList.add(filterKey);
    } else {
      selectedAssignedToList.remove(filterKey);
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

  void resetFilters() {
    categoryFilterModel.value = {
      for (String element in tasksController.categoriesList)
        element.toString(): false
    };

    assignedByFilterModel.value = {
      for (AllUsersModel element in Get.put(UserController()).myTeamList.value!)
        element.emailId.toString(): false
    }.obs;

    assignedToFilterModel.value = {
      for (AllUsersModel element in Get.put(UserController()).myTeamList.value!)
        element.emailId.toString(): false
    }.obs;

    frequencyFilterModel.value = {
      for (String element in frequencyList) element.toString(): false
    };

    priorityFilterModel.value = {
      for (String element in priorityList) element.toString(): false
    };

    selectedCategoryList.value = [];
    selectedAssignedByList.value = [];
    selectedAssignedToList.value = [];
    selectedFrequencyList.value = [];
    selectedPriorityList.value = [];
  }
}
