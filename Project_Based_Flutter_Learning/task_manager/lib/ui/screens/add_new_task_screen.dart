import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/ui/widgets/screen_bagground.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

import '../../data/urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/add-new-task';
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController=TextEditingController();
  final TextEditingController _descriptionTEController=TextEditingController();
   final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
   bool _addNewTaskInProgress= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: ScreenBagground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            autovalidateMode:AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _titleTEController,
                  validator: (String? value){
                    if(value?.trim().isEmpty??true)
                      {
                        return 'Enter your title';
                      }
                    return null;
                  },

                    decoration: InputDecoration(
                    hintText: 'Title'
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionTEController,
                  validator: (String? value){
                    if(value?.trim().isEmpty??true)
                    {
                      return 'Enter your description';
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: 'Description'
                  ),
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: _addNewTaskInProgress ==  false,
                  replacement: CircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapSubmitbutoon,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _onTapSubmitbutoon(){
    if(_formkey.currentState!.validate()){
      _addNewTask();
    }
    // Navigator.pop(context);
  }
  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});
    Map<String, String> requestBody={
       "title":_titleTEController.text.trim(),
      "description":_descriptionTEController.text.trim(),
      "status":"New",
    };
    NetworkResponse response = await NetworkCaller.postRequest(url: Urls.createNewTaskUrl, body: requestBody);

    _addNewTaskInProgress = false;
    setState(() {
    });
    if(response.isSuccess){
      _titleTEController.clear();
      _descriptionTEController.clear();
      showSnackBarMessage(context, 'Added new task');
    }
    else{
      showSnackBarMessage(context, response.errorMessage!);
    }


  }
 @override
  void dispose() {
   _titleTEController.dispose();
   _descriptionTEController.dispose();
    super.dispose();
  }
}
