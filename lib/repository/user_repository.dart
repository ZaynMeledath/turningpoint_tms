import 'package:turning_point_tasks_app/model/user_model.dart';
import 'package:turning_point_tasks_app/service/api/api_endpoints.dart';
import 'package:turning_point_tasks_app/service/api/api_service.dart';

class UserRepository {
//====================User Login====================//
  static Future<UserModelResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.login,
        requestMethod: RequestMethod.POST,
        data: {
          'emailID': email,
          'password': password,
        },
        fieldNameForFiles: null,
        isTokenRequired: false,
      );
      return UserModelResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
