import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import 'centered_circular_progress_indicator.dart';

enum TaskType { tNew, Progress, Completed, Cancelled }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskType,
    required this.taskModel,
    required this.onStatusUpdate,
  });

  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;
  bool _deleteInProgress = false; // Track delete operation

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              widget.taskModel.description,
              style: TextStyle(color: Colors.black54),
            ),
            Text('Date: ${widget.taskModel.createdDate}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(
                    _getTaskTypeName(),
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: _getTaskChipColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
                const Spacer(),
                _buildDeleteButton(), // Delete button
                Visibility(
                  visible: !_updateTaskStatusInProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: IconButton(
                    onPressed: () {
                      _showEditTaskStatusDialog();
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return _deleteInProgress
        ? const Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    )
        : IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () => _showDeleteConfirmationDialog(),
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteTask(); // Call delete task method
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Color _getTaskChipColor() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return Colors.blue;
      case TaskType.Progress:
        return Colors.purple;
      case TaskType.Completed:
        return Colors.green;
      case TaskType.Cancelled:
        return Colors.red;
    }
  }

  String _getTaskTypeName() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return 'New';
      case TaskType.Progress:
        return 'Progress';
      case TaskType.Completed:
        return 'Completed';
      case TaskType.Cancelled:
        return 'Cancelled';
    }
  }

  void _showEditTaskStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('New'),
                trailing: _getTaskStatusTrailing(TaskType.tNew),
                onTap: () => _onTapTaskStatus(TaskType.tNew),
              ),
              ListTile(
                title: const Text('In Progress'),
                trailing: _getTaskStatusTrailing(TaskType.Progress),
                onTap: () => _onTapTaskStatus(TaskType.Progress),
              ),
              ListTile(
                title: const Text('Completed'),
                trailing: _getTaskStatusTrailing(TaskType.Completed),
                onTap: () => _onTapTaskStatus(TaskType.Completed),
              ),
              ListTile(
                title: const Text('Cancelled'),
                trailing: _getTaskStatusTrailing(TaskType.Cancelled),
                onTap: () => _onTapTaskStatus(TaskType.Cancelled),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget? _getTaskStatusTrailing(TaskType type) {
    return widget.taskType == type ? const Icon(Icons.check) : null;
  }

  void _onTapTaskStatus(TaskType type) {
    if (type == widget.taskType) {
      return; // No change needed if the status is the same
    }
    _updateTaskStatus(type.toString().split('.').last); // Convert enum to string
  }

  Future<void> _deleteTask() async {
    _deleteInProgress = true; // Set delete in progress
    if (mounted) setState(() {});

    try {
      final response = await NetworkCaller.getRequest(
        url: Urls.deleteTaskUrl(widget.taskModel.id),
      );

      if (response.isSuccess) {
        widget.onStatusUpdate(); // Refresh the parent list
        showSnackBarMessage(context, 'Task deleted successfully');
      } else {
        showSnackBarMessage(context, response.errorMessage ?? 'Delete failed');
      }
    } finally {
      _deleteInProgress = false; // Reset delete in progress
      if (mounted) setState(() {});
    }
  }

  Future<void> _updateTaskStatus(String status) async {
    Navigator.pop(context);
    _updateTaskStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, status),
    );

    _updateTaskStatusInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      widget.onStatusUpdate();
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
  }
}