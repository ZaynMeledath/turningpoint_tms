import 'package:get/get.dart';

final Iterable categories = [
  'Marketing',
  'Sales',
  'HR/Admin',
];

class FilterController extends GetxController {
  final RxMap<String, bool> categoryFilterModel =
      {for (String element in categories) element.toString(): false}.obs;

  final RxMap<String, bool> assignedFilterModel =
      {for (String element in categories) element.toString(): false}.obs;

  final RxMap<String, bool> frequencyFilterModel =
      {for (String element in categories) element.toString(): false}.obs;

  final RxMap<String, bool> priorityFilterModel =
      {for (String element in categories) element.toString(): false}.obs;
}
