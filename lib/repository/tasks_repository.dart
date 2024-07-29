import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/service/api/api_endpoints.dart';
import 'package:turning_point_tasks_app/service/api/api_service.dart';

class TasksRepository {
//====================Get My Tasks====================//
  Future<List<TasksModel>?> getMyTasks() async {
    final response = await ApiService().sendRequest(
      url: ApiEndpoints.getMyTasks,
      requestMethod: RequestMethod.GET,
      data: {},
      fieldNameForFiles: null,
      isTokenRequired: true,
    );
    return TasksModelResponse.fromJson(response).tasks;
  }
}
