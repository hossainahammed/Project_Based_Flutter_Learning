import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/widgets/task_count_summary_card.dart';
import '../../data/models/task_model.dart';
import '../../data/models/task_status_count_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snackbar_message.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
 // bool _getNewTasksInProgress = false;
  bool _getTaskStatusCountInProgress = false;
 // List<TaskModel> _newTaskList = [];
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Get.find()<NewTaskListScreen>().getNewTaskList();
      Get.find<NewTaskListController>().getNewTaskList();

      _getTaskStatusCountList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: Visibility(
                visible: _getTaskStatusCountInProgress == false,
                replacement: CenteredCircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TaskCountSummaryCard(
                      title: _taskStatusCountList[index].id,
                      count: _taskStatusCountList[index].count,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 4),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<NewTaskListController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.inprogress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ListView.builder(
                      itemCount: controller.newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskType: TaskType.New,
                          taskModel: controller.newTaskList[index],
                          onStatusUpdate: () {
                            // Get.find()<NewTaskListScreen>().getNewTaskList();
                            Get.find<NewTaskListController>().getNewTaskList();

                            _getTaskStatusCountList();
                          },
                        );
                      },
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }



  Future<void> _getTaskStatusCountList() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller
        .getRequest(url: Urls.getTaskStatusCountUrl);

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
    } else {
       // showSnackBarMessage(context, response.errorMessage!);
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }

    _getTaskStatusCountInProgress = false;
    // setState(() {});
    if (mounted) {
      setState(() {});
    }
  }

  void _onTapAddNewTaskButton() {
    // Navigator.pushNamed(context, AddNewTaskScreen.name);
    
    // -----------------------------OR--------------------
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTaskScreen()));

    // -------------------------------------- Or BY USING GETX Normal mode ------------------

    // Get.to(()=>AddNewTaskScreen());

   // ----------------------OR  If we want to Use Named version then ------------
    Get.toNamed(AddNewTaskScreen.name);
    // if we want to pop screen then in getx it is Get.back();
  }
}