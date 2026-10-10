import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/task_provider.dart';
import '../widegts/add_task_dialog.dart';
import '../widegts/statistics_card.dart';
import '../widegts/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => const AddTaskDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6258E8),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.check_circle_outline, size: 28),
            SizedBox(width: 10),
            Text('Task Manager', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskDialog(context),
        backgroundColor: const Color(0xFF6258E8),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
              decoration: const BoxDecoration(
                color: Color(0xFF6258E8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stay Productive!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Organize your tasks and get things done.',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 22, 12, 10),
              child: Row(
                children: [
                  StatisticsCard(
                    title: 'Total Tasks',
                    count: taskProvider.totalTasks,
                    icon: Icons.list_alt,
                    color: const Color(0xFF6258E8),
                  ),
                  const SizedBox(width: 8),
                  StatisticsCard(
                    title: 'Completed',
                    count: taskProvider.completedTasks,
                    icon: Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  StatisticsCard(
                    title: 'Pending',
                    count: taskProvider.pendingTasks,
                    icon: Icons.pending_actions,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Tasks',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF25243A),
                    ),
                  ),
                  Text(
                    '${taskProvider.totalTasks} tasks',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: taskProvider.tasks.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6258E8)
                                    .withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.note_add_outlined,
                                size: 60,
                                color: Color(0xFF6258E8),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'No tasks yet!',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Tap the Add Task button to create your first task.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                      itemCount: taskProvider.tasks.length,
                      itemBuilder: (context, index) {
                        final task = taskProvider.tasks[index];

                        return TaskCard(key: ValueKey(task.id), task: task);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
