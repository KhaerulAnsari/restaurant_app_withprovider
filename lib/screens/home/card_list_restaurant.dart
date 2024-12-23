import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_model.dart';
import 'package:restaurant_app/routes/routes.dart';
import 'package:restaurant_app/screens/favorite/favorite_icon_button.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:unicons/unicons.dart';

class CardListRestaurant extends StatelessWidget {
  final RestaurantModel restaurant;
  final bool isFavorite;
  const CardListRestaurant({
    super.key,
    required this.restaurant,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}';

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.detailRoute.name,
              arguments: restaurant.id,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 80,
                    minHeight: 80,
                    maxWidth: 80,
                    minWidth: 80,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Hero(
                      tag: imageUrl,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        restaurant.description ?? '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Icon(
                            UniconsLine.building,
                            color: TypografyStyle.mainColor,
                            size: isFavorite ? 18 : 22,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: Text(
                              restaurant.city ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    // fontSize: constraints.maxWidth <= 330 ? 12 : 14
                                  ),
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                      (isFavorite == true || constraints.maxWidth <= 330)
                          ? Row(
                              children: [
                                SmoothStarRating(
                                  starCount: 1,
                                  rating: restaurant.rating!,
                                  color: TypografyStyle.mainColor,
                                  borderColor: TypografyStyle.mainColor,
                                  size: isFavorite ? 18 : 22,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  child: Text(
                                    restaurant.rating.toString(),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  width: isFavorite ? 8 : 0,
                ),
                (isFavorite == true || constraints.maxWidth <= 330)
                    ? FavoriteIconButton(
                        restaurant: restaurant,
                        sizeIcon: 28,
                      )
                    : Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          SmoothStarRating(
                            starCount: 1,
                            rating: restaurant.rating!,
                            color: TypografyStyle.mainColor,
                            borderColor: TypografyStyle.mainColor,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            restaurant.rating.toString(),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
