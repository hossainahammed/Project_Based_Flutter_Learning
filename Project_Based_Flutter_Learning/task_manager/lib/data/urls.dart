// class Urls{
//   static const String _baseUrl ='http://35.73.30.144:2005/api/v1';
//   static const String registrationanUrl ='$_baseUrl/Registration';
//   static const String loginUrl ='$_baseUrl/Login';
//   static const String createNewTaskUrl = '$_baseUrl/createTask';
//   static const String getNewTasksUrl = '$_baseUrl/listTaskByStatus/New';
//   static String updateTaskStatusUrl(String taskId, String status) =>
//       '$_baseUrl/updateTaskStatus/$taskId/$status';
//   static const String updateProfileUrl = '$_baseUrl/ProfileUpdate';
//   static const String getProgressTasksUrl = '$_baseUrl/listTaskByStatus/Progress';
//   static const String getTaskStatusCountUrl = '$_baseUrl/taskStatusCount';
//   static const String getCompletedTasksUrl = '$_baseUrl/listTaskByStatus/Completed';
//   static const String getCancelledTasksUrl = '$_baseUrl/listTaskByStatus/Cancelled';
//   static String deleteTaskUrl(String taskId) => '$_baseUrl/deleteTask/$taskId';
//   static const String sendOtpUrl = '$_baseUrl/send-otp';
//
// }
//
class Urls {

  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static String get baseUrl => _baseUrl;


  static const String registrationanUrl = '$_baseUrl/Registration';
  static const String loginUrl = '$_baseUrl/Login';


  static String verifyEmailUrl(String email) => '$_baseUrl/RecoverVerifyEmail/$email';

  static String verifyOtpUrl(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOtp/${Uri.encodeComponent(email)}/$otp';


  static const String resetPasswordUrl = '$_baseUrl/RecoverResetPassword';



  static const String createNewTaskUrl = '$_baseUrl/createTask';
  static const String getNewTasksUrl = '$_baseUrl/listTaskByStatus/New';
  static const String getTaskStatusCountUrl = '$_baseUrl/TaskStatusCount';
  static const String getCompletedTasksUrl = '$_baseUrl/listTaskByStatus/Completed';
  static const String getCancelledTasksUrl = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String getProgressTasksUrl = '$_baseUrl/listTaskByStatus/Progress';

  static String updateTaskStatusUrl(String taskId, String newStatus) {
    return '$_baseUrl/updateTaskStatus/$taskId/$newStatus';
  }


  static String deleteTaskUrl(String taskId) {
    return '$_baseUrl/deleteTask/$taskId';
  }


  static const String profileDetailsUrl = '$_baseUrl/profileDetails';
  static const String updateProfileUrl = '$_baseUrl/ProfileUpdate';
}
