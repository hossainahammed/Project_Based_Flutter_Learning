import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snackbar_message.dart';

class CancelTaskListScreen extends StatefulWidget {
  const CancelTaskListScreen({super.key});

  @override
  State<CancelTaskListScreen> createState() => _CancelTaskListScreenState();
}

class _CancelTaskListScreenState extends State<CancelTaskListScreen> {
  bool _getCancelTasksInProgress = false;
  List<TaskModel> _cancelTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: _getCancelTasksInProgress
          ? const CenteredCircularProgressIndicator()
          : _cancelTaskList.isEmpty
          ? Center(child: Text('No cancelled tasks available.'))
          : RefreshIndicator(
        onRefresh: _getCancelTaskList,
        child: ListView.builder(
          itemCount: _cancelTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskType: TaskType.Cancelled,
              taskModel: _cancelTaskList[index],
              onStatusUpdate: () {
                _getCancelTaskList();
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _getCancelTaskList() async {
    _getCancelTasksInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller
        .getRequest(url: Urls.getCancelledTasksUrl);

    if (response.isSuccess) {
      print(response.body);
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelTaskList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }

    _getCancelTasksInProgress = false;
    setState(() {});
  }
}