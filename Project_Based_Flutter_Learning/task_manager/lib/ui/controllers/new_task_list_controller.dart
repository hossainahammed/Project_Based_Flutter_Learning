import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class NewTaskListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<TaskModel> _newTaskList = [];

  bool get inprogress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get newTaskList => _newTaskList;

  // Rename _getNewTaskList() to a public method
  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getNewTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage!;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
