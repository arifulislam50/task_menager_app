import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  int get totalTasks => _tasks.length;

  int get completedTasks => _tasks.where((task) => task.isCompleted).length;

  int get pendingTasks => totalTasks - completedTasks;

  void addTask({required String title, required String description}) {
    final task = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
    );

    _tasks.add(task);
    notifyListeners();
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);

    if (index == -1) return;

    _tasks[index].isCompleted = !_tasks[index].isCompleted;

    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
