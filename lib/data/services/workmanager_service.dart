import 'package:restaurant_app/data/services/restaurant_services.dart';
import 'package:restaurant_app/data/static/my_workmanager.dart';
import 'package:restaurant_app/provider/local_hour_and_minute_provider.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:developer' as logdev;

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      logdev.log("Task received: $task with inputData: $inputData");
      if (task == MyWorkmanager.oneOff.taskName ||
          task == MyWorkmanager.oneOff.uniqueName ||
          task == Workmanager.iOSBackgroundTask) {
        final localHourMinute = LocalHourAndMinuteProvider();
        final localNotification = LocalNotificationProvider();
        final restaurantService = RestaurantServices();
        final listRestaurant = RestaurantListProvider(restaurantService);

        final restaurnt = await listRestaurant.fetchRandomRestaurant();
        await localHourMinute.getHourAndMinute();

        int hour = int.parse(localHourMinute.hourAndMinute[0]);
        int minute = int.parse(localHourMinute.hourAndMinute[1]);

        await localNotification.configureLocalTImezone();

        await localNotification.scheduleDailyTenAMNotification(
          hour: hour,
          minute: minute,
          notifTitle: restaurnt.name ?? 'This is title Notif',
          notifBody: restaurnt.description ?? 'This is body Notif',
          payload: restaurnt.id ?? '123',
        );
      } else if (task == MyWorkmanager.periodic.taskName) {
        logdev.log("Work Manager Run");
      }
      return Future.value(true);
    } catch (e) {
      logdev.log("Error: $e");
      return Future.value(false);
    }
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
      : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: false);
  }

  Future<void> runOneOffTask() async {
    await _workmanager.registerOneOffTask(
      MyWorkmanager.oneOff.uniqueName,
      MyWorkmanager.oneOff.taskName,
      // initialDelay: const Duration(seconds: 10),
      inputData: {
        "data": "This is a valid payload from oneoff task workmanager",
      },
    );
  }

  Future<void> runPeriodicTask() async {
    await _workmanager.registerPeriodicTask(
      MyWorkmanager.periodic.uniqueName,
      MyWorkmanager.periodic.taskName,
      frequency: const Duration(minutes: 16),
      initialDelay: Duration.zero,
      inputData: {
        "data": "This is a valid payload from periodic task workmanager",
      },
    );
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}
