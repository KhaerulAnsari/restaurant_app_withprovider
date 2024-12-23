import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';
import 'package:restaurant_app/screens/home/card_list_restaurant.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<LocalDatabaseProvider>().loadAllRestaurant();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Favorite Restaurant"),
        ),
        body: Consumer<LocalDatabaseProvider>(
          builder: (context, value, child) {
            final favoriteList = value.restaurantList ?? [];

            return switch (favoriteList.isNotEmpty) {
              true => ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: TypografyStyle.defaultMargin,
                  ),
                  itemCount: favoriteList.length,
                  itemBuilder: (context, index) {
                    final restaurant = favoriteList[index];

                    return CardListRestaurant(
                      restaurant: restaurant,
                      isFavorite: true,
                    );
                  },
                ),
              _ => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No Favorite"),
                    ],
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
