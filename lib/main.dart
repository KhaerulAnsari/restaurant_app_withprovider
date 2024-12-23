// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/data/services/local_database_service.dart';
import 'package:restaurant_app/data/services/local_notification_services.dart';
import 'package:restaurant_app/data/services/local_theme_service.dart';
import 'package:restaurant_app/data/services/restaurant_services.dart';
import 'package:restaurant_app/provider/index_nav_provider.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';
import 'package:restaurant_app/provider/local_hour_and_minute_provider.dart';
import 'package:restaurant_app/provider/local_icon_notif_provider.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';
import 'package:restaurant_app/provider/payload_provider.dart';
import 'package:restaurant_app/provider/restaurant_add_review_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_search_provider.dart';
import 'package:restaurant_app/provider/theme_provider.dart';
import 'package:restaurant_app/provider/workmanager_provider.dart';
import 'package:restaurant_app/routes/routes.dart';
import 'package:restaurant_app/screens/detail_restaurant/detail_restauran_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/screens/main/main_screen.dart';
import 'package:restaurant_app/screens/search_restaurant/search_restaurant_screen.dart';
import 'package:restaurant_app/screens/setting/setting_screen.dart';
import 'package:restaurant_app/style/theme/theme_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  String route = Routes.mainRoute.name;

  // TAHAP 3
  String? payload;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    final notificationResponse =
        notificationAppLaunchDetails!.notificationResponse;
    route = Routes.detailRoute.name;
    payload = notificationResponse?.payload;
  }

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => RestaurantServices(),
        ),
        Provider(
          create: (context) => LocalThemeCervice(),
        ),
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) => PayloadProvider(
            payload: payload,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<RestaurantServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<RestaurantServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            context.read<LocalThemeCervice>(),
          )..loadThemeMode(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListSearchProvider(
            context.read<RestaurantServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantAddReviewProvider(
            context.read<RestaurantServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalHourAndMinuteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WorkmanagerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalIconNotifProvider(),
        )
      ],
      child: MyApp(
        initialRoute: route,
        id: payload ?? '',
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final String id;
  const MyApp({
    super.key,
    required this.initialRoute,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Restaurant App',
          theme: ThemeStyle.lightTheme,
          darkTheme: ThemeStyle.darkTheme,
          themeMode: themeNotifier.themeMode,
          // initialRoute: Routes.mainRoute.name,
          initialRoute: initialRoute,
          routes: {
            Routes.mainRoute.name: (context) => const MainScreen(),
            Routes.homeRoute.name: (context) => const HomeScreen(),
            Routes.settingRoute.name: (context) => const SettingScreen(),
            Routes.detailRoute.name: (context) => DetailRestaurantList(
                  id: ModalRoute.of(context)?.settings.arguments as String? ??
                      id,
                ),
            Routes.searchRestaurantRoute.name: (context) =>
                const SearchRestaurantScreen()
          },
        );
      },
    );
  }
}
