class ApiEndpoints {
  // static const baseUrl = 'https://api.turningpointvapi.com/tms/api';
  // static const webSocketUrl = 'ws://api.turningpointvapi.com/tms/';

  static const localIp = '192.168.1.123:5001';
  static const baseUrl = 'http://$localIp/api';
  static const webSocketUrl = 'ws://$localIp/';

  // static const baseUrl = 'http://13.203.53.210/api';
  // static const webSocketUrl = 'ws://13.203.53.210/';

  static const register = '$baseUrl/auth/register';
  static const logIn = '$baseUrl/auth/login';
  static const logOut = '$baseUrl/auth/logout';
  static const users = '$baseUrl/users';
  static const blockUser = '$baseUrl/users/block';
  static const updateProfile = '$baseUrl/users/profile';
  static const getAssignTaskUsers = '$baseUrl/users/assign';
  static const getAllTasks = '$baseUrl/tasks';
  static const getMyTasks = '$baseUrl/tasks/mytasks';
  static const getDelegatedTasks = '$baseUrl/tasks/delegatedtasks';
  static const assignTask = '$baseUrl/tasks';
  static const approveTask = '$baseUrl/tasks/approveTask';
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
