import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/received_notification.dart';
import 'package:restaurant_app/data/services/local_notification_services.dart';
import 'package:restaurant_app/provider/index_nav_provider.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';
import 'package:restaurant_app/provider/payload_provider.dart';
import 'package:restaurant_app/provider/workmanager_provider.dart';
import 'package:restaurant_app/routes/routes.dart';
import 'package:restaurant_app/screens/favorite/favorite_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/screens/setting/setting_screen.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';
import 'package:unicons/unicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    _configureSelectNotificationSubject(context);
    _configureDidReceiveLocalNotificationSubject(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocalNotificationProvider>()
        ..init()
        ..requestPermissions()
        ..configureLocalTImezone();
      context.read<WorkmanagerProvider>().init();
    });
  }

  void _configureSelectNotificationSubject(BuildContext context) {
    final navigator = Navigator.of(context);
    final payloadProvider = context.read<PayloadProvider>();

    selectNotificationStream.stream.listen((String? payload) {
      payloadProvider.payload = payload;
      navigator.pushNamed(Routes.detailRoute.name, arguments: payload);
    });
  }

  void _configureDidReceiveLocalNotificationSubject(BuildContext context) {
    final navigator = Navigator.of(context);
    final payloadProvider = context.read<PayloadProvider>();

    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) {
      final payload = receivedNotification.payload;
      payloadProvider.payload = payload;
      navigator.pushNamed(Routes.detailRoute.name, arguments: payload);
    });
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    didReceiveLocalNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavbar) {
            1 => const FavoriteScreen(),
            2 => const SettingScreen(),
            _ => const HomeScreen(),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: TypografyStyle.mainColor,
        backgroundColor: Theme.of(context).cardColor,
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavbar,
        onTap: (index) {
          context.read<IndexNavProvider>().setIndexBottomNavbar(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(UniconsLine.estate),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(UniconsLine.heart_alt),
            label: "Favorite",
            tooltip: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(UniconsLine.setting),
            label: "Setting",
            tooltip: "Setting",
          ),
        ],
      ),
    );
  }
}
