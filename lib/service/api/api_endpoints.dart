class ApiEndpoints {
  static const baseUrl = 'http://192.168.1.127:5001/api';

  static const login = '$baseUrl/auth/login';
  static const register = '$baseUrl/auth/register';
  static const getAllTeamMembers = '$baseUrl/users';
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
}
