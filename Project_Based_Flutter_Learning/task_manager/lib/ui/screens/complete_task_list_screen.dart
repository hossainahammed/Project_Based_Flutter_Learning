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
    _getCompleteTaskList(); // Fetch the complete task list when the screen is initialized
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
    _getCompleteTasksInProgress = true; // Set loading state
    setState(() {});

    NetworkResponse response = await NetworkCaller
        .getRequest(url: Urls.getCompletedTasksUrl);

    if (response.isSuccess) {
      print(response.body); // Log the response for debugging
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData)); // Parse each task
      }
      _completeTaskList = list; // Update the complete task list
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }

    _getCompleteTasksInProgress = false; // Reset loading state
    setState(() {});
  }
}