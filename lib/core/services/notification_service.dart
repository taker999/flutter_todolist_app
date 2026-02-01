import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService(this.flutterLocalNotificationsPlugin);

  int notifId(int taskId, int offset) => (taskId * 2) + offset;

  Future<void> scheduleTaskNotification(Task task) async {
    if (!task.hasReminder) return;

    log(
      'Scheduling notifications for task: ${task.id} - ${task.title}',
      name: 'NotificationService',
    );

    try {
      // 1 hour before due date
      await _scheduleNotification(
        id: notifId(task.id!, 0),
        title: 'Task Reminder: ${task.title}',
        body: 'Due in 1 hour - ${task.description}',
        scheduledTime: task.dueDate.subtract(const Duration(hours: 1)),
      );

      log(
        'Scheduled 1-hour reminder for task ${task.id}',
        name: 'NotificationService',
      );
    } catch (e, stackTrace) {
      log(
        'Error scheduling 1-hour reminder for task ${task.id}',
        name: 'NotificationService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    }

    try {
      // At due date
      await _scheduleNotification(
        id: notifId(task.id!, 1),
        title: 'Task Due: ${task.title}',
        body: 'This task is due now - ${task.description}',
        scheduledTime: task.dueDate,
      );

      log(
        'Scheduled due date reminder for task ${task.id}',
        name: 'NotificationService',
      );
    } catch (e, stackTrace) {
      log(
        'Error scheduling due date reminder for task ${task.id}',
        name: 'NotificationService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    }
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    try {
      if (scheduledTime.isBefore(DateTime.now())) {
        log(
          'Scheduled time has passed for notification ID: $id',
          name: 'NotificationService',
          level: 900,
        );
        return;
      }

      final tzDateTime = tz.TZDateTime.from(scheduledTime, tz.local);

      log(
        'Scheduling notification ID: $id at $tzDateTime',
        name: 'NotificationService',
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzDateTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_reminders',
            'Task Reminders',
            channelDescription: 'Notifications for upcoming tasks',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      log(
        'Successfully scheduled notification ID: $id',
        name: 'NotificationService',
      );
    } catch (e, stackTrace) {
      log(
        'Error scheduling notification ID: $id',
        name: 'NotificationService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    }
  }

  Future<void> cancelTaskNotification(int taskId) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(notifId(taskId, 0));
      await flutterLocalNotificationsPlugin.cancel(notifId(taskId, 1));

      log(
        'Cancelled notifications for task $taskId',
        name: 'NotificationService',
      );
    } catch (e, stackTrace) {
      log(
        'Error cancelling notifications for task $taskId',
        name: 'NotificationService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    }
  }

  Future<void> showInstantNotification(String title, String body) async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'instant_notifications',
            'Instant Notifications',
            channelDescription: 'Immediate notifications for tasks',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(),
      );

      await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch % 100000,
        title,
        body,
        notificationDetails,
      );

      log('Showed instant notification: $title', name: 'NotificationService');
    } catch (e, stackTrace) {
      log(
        'Error showing instant notification',
        name: 'NotificationService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    }
  }

  Future<void> checkOverdueTasks(List<Task> tasks) async {
    try {
      for (var task in tasks) {
        if (task.isOverdue && !task.isCompleted) {
          await showInstantNotification(
            'Overdue Task: ${task.title}',
            'This task was due on ${task.dueDate.toString().split('.')[0]}',
          );
        }
      }
    } catch (e, stackTrace) {
      log(
        'Error checking overdue tasks',
        name: 'NotificationService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
    }
  }
}
