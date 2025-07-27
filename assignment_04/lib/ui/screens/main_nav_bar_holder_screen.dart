import 'package:assignment_04/ui/screens/progress_task_list_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/tm_app_bar.dart';
import 'cancel_task_list_screen.dart';
import 'complete_task_list_screen.dart';
import 'new_task_list_screen.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});
  static const String name = '/main-nav-bar-holder';

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {
  List<Widget> _screen = [NewTaskListScreen(),ProgressTaskListScreen(),CompleteTaskListScreen(),CancelTaskListScreen()];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: _screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: 'Progress',
          ),
          NavigationDestination(icon: Icon(Icons.done), label: 'Complete'),
          NavigationDestination(icon: Icon(Icons.close), label: 'Cancel'),
        ],
      ),
    );
  }
}

