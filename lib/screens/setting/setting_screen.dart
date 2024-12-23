import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/local_hour_and_minute_provider.dart';
import 'package:restaurant_app/provider/local_icon_notif_provider.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';
import 'package:restaurant_app/provider/theme_provider.dart';
import 'package:restaurant_app/provider/workmanager_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool isActiveNotiv = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocalHourAndMinuteProvider>().getHourAndMinute();
      context.read<LocalIconNotifProvider>().loadActiveNotiv();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localHourAndMinute = Provider.of<LocalHourAndMinuteProvider>(context);
    final isActivIcon = Provider.of<LocalIconNotifProvider>(context);
    final workManager = Provider.of<WorkmanagerProvider>(context);
    final localNotif = Provider.of<LocalNotificationProvider>(context);
    ThemeProvider themeNotifier = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Setting"),
          centerTitle: true,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              darkMode(isDarkMode),
              const SizedBox(
                height: 8,
              ),
              dailyReminder(
                localHourAndMinute,
                isActivIcon,
                workManager,
                localNotif,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Consumer<LocalHourAndMinuteProvider> darkMode(bool isDarkMode) {
    return Consumer<LocalHourAndMinuteProvider>(
      builder: (context, date, child) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text('Dark Mode'),
              ),
              Switch(
                value: isDarkMode,
                activeColor: Colors.amber,
                activeTrackColor: Colors.cyan,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                onChanged: (value) async {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Consumer<LocalHourAndMinuteProvider> dailyReminder(
      LocalHourAndMinuteProvider localHourAndMinute,
      LocalIconNotifProvider isActivIcon,
      WorkmanagerProvider workManager,
      LocalNotificationProvider localNotif) {
    return Consumer<LocalHourAndMinuteProvider>(
      builder: (context, date, child) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              (date.hourAndMinute.isEmpty)
                  ? const Expanded(
                      child: Text('Setel Waktu Pemberitahuan'),
                    )
                  : Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: _selectedTime,
                          );

                          if (pickedTime != null &&
                              pickedTime != _selectedTime) {
                            setState(
                              () {
                                _selectedTime = pickedTime;
                                localHourAndMinute.saveHourAndMinute(
                                  pickedTime.hour.toString(),
                                  pickedTime.minute.toString(),
                                );

                                if (isActivIcon.isActiveNotif) {
                                  workManager.runOneOffTask();
                                }
                              },
                            );
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Daily Reminder',
                            ),
                            Text(
                              '${date.hourAndMinute[0]} : ${date.hourAndMinute[1].length > 1 ? date.hourAndMinute[1] : '0${date.hourAndMinute[1]}'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Switch(
                value: isActivIcon.isActiveNotif,
                activeColor: Colors.amber,
                activeTrackColor: Colors.cyan,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                onChanged: (value) async {
                  if (date.hourAndMinute.isEmpty) {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );

                    if (pickedTime != null && pickedTime != _selectedTime) {
                      setState(
                        () {
                          _selectedTime = pickedTime;
                          localHourAndMinute.saveHourAndMinute(
                            pickedTime.hour.toString(),
                            pickedTime.minute.toString(),
                          );

                          isActivIcon.saveActiveNotiv(value);
                          workManager.runOneOffTask();
                        },
                      );
                    }
                  } else {
                    setState(() {
                      isActivIcon.saveActiveNotiv(value);
                      if (value == true) {
                        workManager.runOneOffTask();
                      } else if (value == false) {
                        workManager.cancelTask();
                        localNotif.cancelNotification();
                      }
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
