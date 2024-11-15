import 'package:get/get.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/model/all_users_model.dart';

final priorityList = ['High', 'Medium', 'Low'];

final frequencyList = ['Once', 'Daily', 'Weekly', 'Monthly'];

// class FilterOptions {
//   static const category = 'category';
//   static const assignedBy = 'assignedBy';
//   static const assignedTo = 'assignedTo';
//   static const frequency = 'frequency';
//   static const priority = 'priority';
//   static const dateRange = 'dateRange';
// }

enum FilterOptions {
  category,
  assignedBy,
  assignedTo,
  frequency,
  priority,
  dateRange,
}

class FilterController extends GetxController {
  FilterController() {
    assignValuesToModels();
  }
  final TasksController tasksController = Get.put(TasksController());
  final userController = Get.put(UserController());

  // RxMap<String, bool> filterOptionSelectedMap = {
  //   'category': true,
  //   'assignedBy': false,
  //   'assignedTo': false,
  //   'frequency': false,
  //   'priority': false,
  // }.obs;

  RxList<FilterOptions> filterOptionSelectedMap = [
    FilterOptions.category,
    FilterOptions.assignedBy,
    FilterOptions.assignedTo,
    FilterOptions.frequency,
    FilterOptions.priority,
  ].obs;

//Defines the currently selected filter bottom sheet option
  Rx<FilterOptions> selectedFilterOption = FilterOptions.category.obs;

  final RxMap<String, bool> categoryFilterModel = <String, bool>{}.obs;
  final RxMap<String, bool> assignedByFilterModel = <String, bool>{}.obs;
  final RxMap<String, bool> assignedToFilterModel = <String, bool>{}.obs;
  final RxMap<String, bool> frequencyFilterModel = <String, bool>{}.obs;
  final RxMap<String, bool> priorityFilterModel = <String, bool>{}.obs;

//To filter with search in filter bottom sheet
  RxList<String> categoriesSearchList = RxList<String>();
  RxList<AllUsersModel> assignedBySearchList = RxList<AllUsersModel>();
  RxList<AllUsersModel> assignedToSearchList = RxList<AllUsersModel>();

  final RxList selectedCategoryList = [].obs;
  final RxList selectedAssignedByList = [].obs;
  final RxList selectedAssignedToList = [].obs;
  final RxList selectedFrequencyList = [].obs;
  final RxList selectedPriorityList = [].obs;
  final Rxn<DateTime> selectedStartDate = Rxn<DateTime>();
  final Rxn<DateTime> selectedEndDate = Rxn<DateTime>();

//====================Assign Values to Models====================//
  void assignValuesToModels() {
    categoryFilterModel.value = {
      for (String element in tasksController.categoriesList)
        element.toString(): false
    };

    if (userController.assignTaskUsersList.value != null) {
      assignedByFilterModel.value = {
        for (AllUsersModel element in userController.assignTaskUsersList.value!)
          element.emailId.toString(): false
      };

      assignedToFilterModel.value = {
        for (AllUsersModel element in userController.assignTaskUsersList.value!)
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
  void selectFilterOption({required FilterOptions filterOption}) {
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
    filterTasks();
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
    filterTasks();
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
    filterTasks();
  }

//====================Select or Unselect Assign To Filters====================//
  void selectOrUnselectAssignToUsers({
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
    filterTasks();
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
    filterTasks();
  }

//====================Filter Tasks====================//
  void filterTasks() {
    if (selectedStartDate.value != null && selectedEndDate.value != null) {
      if (selectedStartDate.value!.isAfter(selectedEndDate.value!)) {
        showGenericDialog(
            iconPath: 'assets/lotties/task_Open_animation.json',
            title: 'Date Order Mismatch',
            content: 'End date should be after start date',
            buttons: {'OK': null});
        return;
      }
    }
    if (tasksController.isDelegatedObs.value == true) {
      tasksController.delegatedTasksListObs.value =
          tasksController.tempDelegatedTasksListObs.value?.where((item) {
        if ((selectedCategoryList.isNotEmpty
                ? selectedCategoryList.contains(item.category)
                : true) &&
            (selectedAssignedToList.isNotEmpty
                ? selectedAssignedToList.contains(item.assignedTo?.first)
                : true) &&
            (selectedAssignedByList.isNotEmpty
                ? selectedAssignedByList.contains(item.createdBy)
                : true) &&
// (filterController.selectedFrequencyList.isNotEmpty ? filterController.selectedFrequencyList.contains(item.)) &&
            (selectedPriorityList.isNotEmpty
                ? selectedPriorityList.contains(item.priority)
                : true) &&
            (selectedStartDate.value != null
                ? DateTime.parse(item.dueDate!)
                        .isAfter(selectedStartDate.value!) ||
                    DateTime.parse(item.dueDate!)
                        .isAtSameMomentAs(selectedStartDate.value!)
                : true) &&
            (selectedEndDate.value != null
                ? selectedStartDate.value != null
                    ? (DateTime.parse(item.dueDate!)
                                .isBefore(selectedEndDate.value!) &&
                            DateTime.parse(item.dueDate!)
                                .isAfter(selectedStartDate.value!)) ||
                        (DateTime.parse(item.dueDate!)
                                .isAtSameMomentAs(selectedEndDate.value!) &&
                            DateTime.parse(item.dueDate!)
                                .isAfter(selectedStartDate.value!))
                    : DateTime.parse(item.dueDate!)
                            .isBefore(selectedEndDate.value!) ||
                        DateTime.parse(item.dueDate!)
                            .isAtSameMomentAs(selectedEndDate.value!)
                : true)) {
          return true;
        } else {
          return false;
        }
      }).toList();
      tasksController.getDelegatedTasks(filter: true);
    } else if (tasksController.isDelegatedObs.value == false) {
      tasksController.myTasksListObs.value =
          tasksController.tempMyTasksListObs.value?.where((item) {
        if ((selectedCategoryList.isNotEmpty
                ? selectedCategoryList.contains(item.category)
                : true) &&
            (selectedAssignedToList.isNotEmpty
                ? selectedAssignedToList.contains(item.assignedTo)
                : true) &&
            (selectedAssignedByList.isNotEmpty
                ? selectedAssignedByList.contains(item.createdBy)
                : true) &&
// (filterController.selectedFrequencyList.isNotEmpty ? filterController.selectedFrequencyList.contains(item.)) &&
            (selectedPriorityList.isNotEmpty
                ? selectedPriorityList.contains(item.priority)
                : true) &&
            (selectedEndDate.value != null
                ? selectedStartDate.value != null
                    ? (DateTime.parse(item.dueDate!)
                                .isBefore(selectedEndDate.value!) &&
                            DateTime.parse(item.dueDate!)
                                .isAfter(selectedStartDate.value!)) ||
                        (DateTime.parse(item.dueDate!)
                                .isAtSameMomentAs(selectedEndDate.value!) &&
                            DateTime.parse(item.dueDate!)
                                .isAfter(selectedStartDate.value!))
                    : DateTime.parse(item.dueDate!)
                            .isBefore(selectedEndDate.value!) ||
                        DateTime.parse(item.dueDate!).isAtSameMomentAs(
                          selectedEndDate.value!.add(const Duration(days: 1)),
                        )
                : true)) {
          return true;
        } else {
          return false;
        }
      }).toList();

      tasksController.getMyTasks(filter: true);
    } else {
      tasksController.dashboardTasksListObs.value =
          tasksController.tempDashboardTasksListObs.where((item) {
        if ((selectedCategoryList.isNotEmpty
                ? selectedCategoryList.contains(item.category)
                : true) &&
            (selectedAssignedToList.isNotEmpty
                ? selectedAssignedToList.contains(item.assignedTo)
                : true) &&
            (selectedAssignedByList.isNotEmpty
                ? selectedAssignedByList.contains(item.createdBy)
                : true) &&
// (filterController.selectedFrequencyList.isNotEmpty ? filterController.selectedFrequencyList.contains(item.)) &&
            (selectedPriorityList.isNotEmpty
                ? selectedPriorityList.contains(item.priority)
                : true) &&
            (selectedEndDate.value != null
                ? selectedStartDate.value != null
                    ? (DateTime.parse(item.dueDate!)
                                .isBefore(selectedEndDate.value!) &&
                            DateTime.parse(item.dueDate!)
                                .isAfter(selectedStartDate.value!)) ||
                        (DateTime.parse(item.dueDate!)
                                .isAtSameMomentAs(selectedEndDate.value!) &&
                            DateTime.parse(item.dueDate!)
                                .isAfter(selectedStartDate.value!))
                    : DateTime.parse(item.dueDate!)
                        .isBefore(selectedEndDate.value!)
                : true)) {
          return true;
        } else {
          return false;
        }
      }).toList();
    }
  }

//====================Reset Filters====================//
  void resetFilters() {
    categoryFilterModel.value = {
      for (String element in tasksController.categoriesList)
        element.toString(): false
    };

    assignedByFilterModel.value = {
      for (AllUsersModel element
          in userController.assignTaskUsersList.value ?? [])
        element.emailId.toString(): false
    }.obs;

    assignedToFilterModel.value = {
      for (AllUsersModel element
          in userController.assignTaskUsersList.value ?? [])
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
    selectedStartDate.value = null;
    selectedEndDate.value = null;

    if (tasksController.isDelegatedObs.value == true) {
      tasksController.getDelegatedTasks(getFromLocalStorage: true);
    } else if (tasksController.isDelegatedObs.value == false) {
      tasksController.getMyTasks(getFromLocalStorage: true);
    } else {
      tasksController.getDashboardTasksFromStorage();
    }
  }
}
