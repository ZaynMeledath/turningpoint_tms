class ApiEndpoints {
  static const baseUrl = 'http://192.168.1.146:5001/api';
  static const login = '$baseUrl/auth/login';
  static const getMyTasks = '$baseUrl/tasks/mytasks';
  static const getDelegatedTasks = '$baseUrl/tasks/delegatedtasks';
  static const getAllTeamMembers = '$baseUrl/users';
}
