import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/static/restaurant_list_state.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/theme_provider.dart';
import 'package:restaurant_app/routes/routes.dart';
import 'package:restaurant_app/screens/home/card_list_restaurant.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';
import 'package:restaurant_app/style/widgets/circular_progres.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<ThemeMode> onThemeChanged;
  const HomeScreen({super.key, required this.onThemeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: TypografyStyle.defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 35,
            ),
            buttonChangeTheme(context, isDarkMode),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                'What do you want\nfor launch?',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Restaurant',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            listRestaurant(),
          ],
        ),
      ),
    );
  }

  Consumer<RestaurantListProvider> listRestaurant() {
    return Consumer<RestaurantListProvider>(
      builder: (context, value, child) {
        return switch (value.resultState) {
          RestaurantListLoadingState() => const CircularProgres(),
          RestaurantListLoadedState(data: var restaurants) => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return CardListRestaurant(
                  restaurant: restaurant,
                );
              },
            ),
          RestaurantListFailureState(message: var errorMessage) => Center(
              child: Text(
                errorMessage,
              ),
            ),
          _ => const SizedBox()
        };
      },
    );
  }

  Row buttonChangeTheme(BuildContext context, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          icon: Icon(
            isDarkMode ? UniconsLine.sunset : UniconsLine.moonset,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.searchRestaurantRoute.name,
            );
          },
          icon: const Icon(
            UniconsLine.search,
          ),
        ),
      ],
    );
  }
}