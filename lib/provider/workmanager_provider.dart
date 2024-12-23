import 'package:flutter/material.dart';
import 'package:restaurant_app/data/services/workmanager_service.dart';

class WorkmanagerProvider extends ChangeNotifier {
  WorkmanagerService workManagerService = WorkmanagerService();

  Future<void> init() async {
    await workManagerService.init();
  }

  Future<void> runOneOffTask() async {
    await workManagerService.runOneOffTask();
  }

  Future<void> runPeriodicTask() async {
    await workManagerService.runPeriodicTask();
  }

  Future<void> cancelTask() async {
    await workManagerService.cancelAllTask();
  }
}
