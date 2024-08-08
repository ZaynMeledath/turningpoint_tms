class ApiEndpoints {
  static const baseUrl = 'http://192.168.1.123:5001/api';
  static const login = '$baseUrl/auth/login';
  static const register = '$baseUrl/auth/register';
  static const getAllTeamMembers = '$baseUrl/users';
  static const getMyTasks = '$baseUrl/tasks/mytasks';
  static const getDelegatedTasks = '$baseUrl/tasks/delegatedtasks';
  static const assignTask = '$baseUrl/tasks';
  static const allUsersPerformanceReport =
      '$baseUrl/dashboard/allusersperformance';
}
