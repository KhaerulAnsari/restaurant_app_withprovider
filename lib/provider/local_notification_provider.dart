import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/services/local_notification_services.dart';

class LocalNotificationProvider extends ChangeNotifier {
  LocalNotificationServices flutterNotificationService =
      LocalNotificationServices();

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  Future<void> init() async {
    await flutterNotificationService.init();
  }

  Future<void> configureLocalTImezone() async {
    await flutterNotificationService.configureLocalTimeZone();
  }

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  Future<void> showNotification() async {
    _notificationId += 1;
    flutterNotificationService.showNotification(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new notification with id $_notificationId",
      payload: "This is a payload from notification with id $_notificationId",
    );
  }

  Future<void> scheduleDailyTenAMNotification(
      {required int hour,
      required int minute,
      required String notifTitle,
      required String notifBody,
      required String payload}) async {
    _notificationId += 1;
    await flutterNotificationService.scheduleDailyTenAMNotification(
      id: _notificationId,
      hour: hour,
      minute: minute,
      notifTitle: notifTitle,
      notifBody: notifBody,
      payload: payload,
    );
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests =
        await flutterNotificationService.pendingNotificationRequests();
    notifyListeners();
  }

  Future<void> cancelNotification() async {
    _notificationId += 1;
    await flutterNotificationService.cancelNotification(_notificationId);
  }
}
