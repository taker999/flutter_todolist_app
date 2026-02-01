import 'package:flutter_todolist_app/core/enums/priority_level.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int priority;

  @HiveField(4)
  final DateTime dueDate;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final bool isCompleted;

  @HiveField(7)
  final bool hasReminder;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    DateTime? createdAt,
    this.isCompleted = false,
    this.hasReminder = false,
  }) : createdAt = createdAt ?? DateTime.now();

  Task copyWith({
    int? id,
    String? title,
    String? description,
    int? priority,
    DateTime? dueDate,
    DateTime? createdAt,
    bool? isCompleted,
    bool? hasReminder,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
      hasReminder: hasReminder ?? this.hasReminder,
    );
  }

  // Helper methods
  String get priorityText {
    switch (priority) {
      case 1:
        return PriorityLevel.high.name.toUpperCase();
      case 2:
        return PriorityLevel.medium.name.toUpperCase();
      case 3:
        return PriorityLevel.low.name.toUpperCase();
      default:
        return PriorityLevel.medium.name.toUpperCase();
    }
  }

  bool get isDueSoon {
    final now = DateTime.now();
    final difference = dueDate.difference(now);
    return difference.inHours <= 24 && difference.inHours > 0;
  }

  bool get isOverdue {
    return DateTime.now().isAfter(dueDate) && !isCompleted;
  }
}
