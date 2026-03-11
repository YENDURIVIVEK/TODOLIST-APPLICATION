import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static const String _taskKey = "tasks";

  /// Save full task list to local storage
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> taskMaps = tasks
        .map((task) => task.toJson())
        .toList();

    String jsonString = jsonEncode(taskMaps);

    await prefs.setString(_taskKey, jsonString);
  }

  /// Load tasks from local storage
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString(_taskKey);

    if (jsonString == null) {
      return [];
    }

    List decoded = jsonDecode(jsonString);

    return decoded.map((task) => Task.fromJson(task)).toList();
  }

  /// Add a new task
  static Future<void> addTask(Task task) async {
    List<Task> tasks = await loadTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  /// Update existing task
  static Future<void> updateTask(Task updatedTask) async {
    List<Task> tasks = await loadTasks();

    int index = tasks.indexWhere((task) => task.id == updatedTask.id);

    if (index != -1) {
      tasks[index] = updatedTask;
      await saveTasks(tasks);
    }
  }

  /// Delete task
  static Future<void> deleteTask(String id) async {
    List<Task> tasks = await loadTasks();

    tasks.removeWhere((task) => task.id == id);

    await saveTasks(tasks);
  }

  /// Clear all tasks
  static Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_taskKey);
  }
}
