class ApiEndpoints {
//   static const baseUrl = 'http://13.126.184.197/tms/api';
  static const baseUrl = 'http://192.168.1.139:5001/api';

  static const register = '$baseUrl/auth/register';
  static const logIn = '$baseUrl/auth/login';
  static const logOut = '$baseUrl/auth/logout';
  static const users = '$baseUrl/users';
  static const updateProfile = '$baseUrl/users/profile';
  static const getAssignTaskUsers = '$baseUrl/users/assign';
  static const getAllTasks = '$baseUrl/tasks';
  static const getMyTasks = '$baseUrl/tasks/mytasks';
  static const getDelegatedTasks = '$baseUrl/tasks/delegatedtasks';
  static const assignTask = '$baseUrl/tasks';
  static const getCategories = '$baseUrl/category/getCategories';
  static const allUsersPerformanceReport =
      '$baseUrl/dashboard/allusersperformance';
  static const allCategoriesPerformanceReport =
      '$baseUrl/dashboard/allcategoryperformance';
  static const myPerformanceReport = '$baseUrl/dashboard/my-report';
  static const delegatedPerformanceReport =
      '$baseUrl/dashboard/delegated-tasks-performance';
  static const uploadFile = '$baseUrl/upload';
  static const addCategory = '$baseUrl/category';
  static const personalReminder = '$baseUrl/notification/reminder';
}
