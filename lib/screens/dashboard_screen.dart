import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import 'auth_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Task> _tasks = [];

  Future<void> _addTask() async {
    final Task? newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (newTask != null) {
      setState(() {
        _tasks.add(newTask);
      });
    }
  }

  void _toggleComplete(Task task) {
    setState(() {
      task.toggleComplete();
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  Widget _buildTaskCard(Task task) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => _toggleComplete(task),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),

            const SizedBox(height: 5),

            Text(
              "Deadline: ${task.deadline}",
              style: const TextStyle(fontSize: 12),
            ),

            if (task.completedTime != null)
              Text(
                "Completed: ${task.completedTime}",
                style: const TextStyle(fontSize: 12, color: Colors.green),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: task.getPriorityColor(),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteTask(task),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyTaskView() {
    return const Center(
      child: Text(
        "No Tasks Yet\nAdd your first task!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),

      body: _tasks.isEmpty
          ? _emptyTaskView()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return _buildTaskCard(_tasks[index]);
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
