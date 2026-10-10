import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../provider/task_provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.isCompleted;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        leading: Checkbox(
          value: isCompleted,
          activeColor: const Color(0xFF6258E8),
          onChanged: (value) {
            context.read<TaskProvider>().toggleTask(task.id);
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: isCompleted ? Colors.grey : Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green.withValues(alpha: 0.12)
                      : Colors.orange.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isCompleted ? 'Completed' : 'Pending',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isCompleted
                        ? Colors.green.shade700
                        : Colors.orange.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          tooltip: 'Delete task',
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () {
            context.read<TaskProvider>().deleteTask(task.id);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task deleted successfully')),
            );
          },
        ),
      ),
    );
  }
}
