import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/services/restaurant_services.dart';
import 'package:restaurant_app/provider/restaurant_add_review_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_search_provider.dart';
import 'package:restaurant_app/provider/theme_provider.dart';
import 'package:restaurant_app/screens/detail_restaurant/detail_restauran_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/routes/routes.dart';
import 'package:restaurant_app/screens/search_restaurant/search_restaurant_screen.dart';
import 'package:restaurant_app/style/theme/theme_style.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => RestaurantServices(),
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
          create: (context) => ThemeProvider(),
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<ThemeMode> themeModeNotifier =
        ValueNotifier(ThemeMode.system);

    return Consumer<ThemeProvider>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Restaurant App',
          theme: ThemeStyle.lightTheme,
          darkTheme: ThemeStyle.darkTheme,
          themeMode: themeNotifier.themeMode,
          initialRoute: Routes.mainRoute.name,
          routes: {
            Routes.mainRoute.name: (context) => HomeScreen(
                  onThemeChanged: (newThemeMode) {
                    themeModeNotifier.value = newThemeMode;
                  },
                ),
            Routes.detailRoute.name: (context) => DetailRestaurantList(
                  restaurntId:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
            Routes.searchRestaurantRoute.name: (context) =>
                const SearchRestaurantScreen()
          },
        );
      },
    );
  }
}
