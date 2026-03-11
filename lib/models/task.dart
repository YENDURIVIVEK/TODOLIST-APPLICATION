import 'package:flutter/material.dart';

enum Priority { low, medium, high }

class Task {
  String id;
  String title;
  String description;
  Priority priority;
  DateTime deadline;
  bool isCompleted;
  DateTime? completedTime;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.deadline,
    this.isCompleted = false,
    this.completedTime,
  });

  /// Change task completion status
  void toggleComplete() {
    isCompleted = !isCompleted;
    if (isCompleted) {
      completedTime = DateTime.now();
    } else {
      completedTime = null;
    }
  }

  /// Get color based on priority
  Color getPriorityColor() {
    switch (priority) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
    }
  }

  /// Convert Task -> JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "priority": priority.name,
      "deadline": deadline.toIso8601String(),
      "isCompleted": isCompleted,
      "completedTime": completedTime?.toIso8601String(),
    };
  }

  /// Convert JSON -> Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      priority: Priority.values.firstWhere((e) => e.name == json["priority"]),
      deadline: DateTime.parse(json["deadline"]),
      isCompleted: json["isCompleted"] ?? false,
      completedTime: json["completedTime"] != null
          ? DateTime.parse(json["completedTime"])
          : null,
    );
  }
}
