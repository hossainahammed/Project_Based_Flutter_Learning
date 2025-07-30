import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snackbar_message.dart';

class CompleteTaskListScreen extends StatefulWidget {
  const CompleteTaskListScreen({super.key});

  @override
  State<CompleteTaskListScreen> createState() => _CompleteTaskListScreenState();
}

class _CompleteTaskListScreenState extends State<CompleteTaskListScreen> {
  bool _getCompleteTasksInProgress = false;
  List<TaskModel> _completeTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompleteTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: _getCompleteTasksInProgress
          ? const CenteredCircularProgressIndicator()
          : _completeTaskList.isEmpty
          ? Center(child: Text('No completed tasks available.'))
          : RefreshIndicator(
        onRefresh: _getCompleteTaskList,
        child: ListView.builder(
          itemCount: _completeTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskType: TaskType.Completed,
              taskModel: _completeTaskList[index],
              onStatusUpdate: () {
                _getCompleteTaskList();
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _getCompleteTaskList() async {
    _getCompleteTasksInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller
        .getRequest(url: Urls.getCompletedTasksUrl);

    if (response.isSuccess) {
     // print(response.body);
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _completeTaskList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }

    _getCompleteTasksInProgress = false;
    setState(() {});
  }
}