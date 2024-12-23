import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_model.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';

class FavoriteIconButton extends StatefulWidget {
  final RestaurantModel restaurant;
  final double sizeIcon;

  const FavoriteIconButton({
    super.key,
    required this.restaurant,
    this.sizeIcon = 32,
  });

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  late ValueNotifier<bool> isFavoriteNotifier;

  @override
  void initState() {
    super.initState();

    isFavoriteNotifier = ValueNotifier<bool>(false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final localDatabaseProvider = context.read<LocalDatabaseProvider>();

      await localDatabaseProvider.loadRestaurantById(widget.restaurant.id!);
      final value =
          localDatabaseProvider.checkItemFavorite(widget.restaurant.id!);

      isFavoriteNotifier.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isFavoriteNotifier,
      builder: (context, isFavorite, child) {
        return GestureDetector(
          onTap: () async {
            final localDatabaseProvider = context.read<LocalDatabaseProvider>();

            if (!isFavorite) {
              await localDatabaseProvider.saveRestaurant(widget.restaurant);
            } else {
              await localDatabaseProvider
                  .removeRestaurantById(widget.restaurant.id!);
            }

            isFavoriteNotifier.value = !isFavorite;
            localDatabaseProvider.loadAllRestaurant();
          },
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
            size: widget.sizeIcon,
          ),
        );
      },
    );
  }
}
