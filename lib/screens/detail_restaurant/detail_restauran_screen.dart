import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model/restaurant_detail_model.dart';
import 'package:restaurant_app/data/models/restaurant_review_model/review_request_model.dart';
import 'package:restaurant_app/data/static/restaurant_add_review_state.dart';
import 'package:restaurant_app/data/static/restaurant_detail_state.dart';
import 'package:restaurant_app/provider/restaurant_add_review_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/screens/detail_restaurant/customer_review_card.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';
import 'package:restaurant_app/style/widgets/circular_progres.dart';
import 'package:restaurant_app/style/widgets/custom_button.dart';
import 'package:restaurant_app/style/widgets/custom_textfield_bg.dart';
import 'package:restaurant_app/style/widgets/info_dialog.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:unicons/unicons.dart';

class DetailRestaurantList extends StatefulWidget {
  final String restaurntId;
  const DetailRestaurantList({super.key, required this.restaurntId});

  @override
  State<DetailRestaurantList> createState() => _DetailRestaurantListState();
}

class _DetailRestaurantListState extends State<DetailRestaurantList> {
  ScrollController scrollReview = ScrollController();
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurntId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const CircularProgres(),
            RestaurantDetailLoadedState(restaurantDetail: var restaurant) =>
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: TypografyStyle.defaultMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    imageAndButtonBack(restaurant, context),
                    const SizedBox(
                      height: 10,
                    ),
                    nameAddressCityAndRating(restaurant, context),
                    const SizedBox(
                      height: 8,
                    ),
                    description(restaurant, context),
                    const SizedBox(
                      height: 8,
                    ),

                    // Menus FOODS
                    Text(
                      'Foods',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    foodMenus(restaurant),
                    const SizedBox(
                      height: 15,
                    ),

                    // Menus DRINKS
                    Text(
                      'Drinks',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    drinkMenus(restaurant),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Review',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    reviewAndAddReview(context, restaurant),

                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            RestaurantDetailFailureState(message: var errorMessage) => Center(
                child: Text(errorMessage),
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }

  Stack imageAndButtonBack(
      RestaurantDetailModel restaurant, BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag:
              'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 280,
              minHeight: 280,
              maxWidth: double.infinity,
              minWidth: double.infinity,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: TypografyStyle.mainColor.withOpacity(
                0.6,
              ),
            ),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ],
    );
  }

  Row nameAddressCityAndRating(
      RestaurantDetailModel restaurant, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    UniconsLine.location_point,
                    color: TypografyStyle.mainColor,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Text(
                      restaurant.address,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    UniconsLine.building,
                    color: TypografyStyle.mainColor,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Text(
                      restaurant.city,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        SmoothStarRating(
          starCount: 1,
          rating: restaurant.rating,
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
    );
  }

  Text description(RestaurantDetailModel restaurant, BuildContext context) {
    return Text(
      restaurant.description,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 12,
          ),
      textAlign: TextAlign.justify,
    );
  }

  SingleChildScrollView foodMenus(RestaurantDetailModel restaurant) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: restaurant.menus.foods
            .map(
              (e) => Container(
                margin: const EdgeInsets.only(
                  right: 8,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  // color: TypografyStyle.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: TypografyStyle.mainColor.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  e.name,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  SingleChildScrollView drinkMenus(RestaurantDetailModel restaurant) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: restaurant.menus.drinks
            .map(
              (e) => Container(
                margin: const EdgeInsets.only(
                  right: 8,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  // color: TypografyStyle.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: TypografyStyle.mainColor.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  e.name,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  ConstrainedBox reviewAndAddReview(
      BuildContext context, RestaurantDetailModel restaurant) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300, maxHeight: 450),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(
                0,
                1,
              ),
            ),
          ],
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // List Review
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: scrollReview,
                  radius: const Radius.circular(5),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(right: 8),
                    controller: scrollReview,
                    child: Column(
                      children: restaurant.customerReviews.map(
                        (itemReview) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: CustomerReviewCard(
                              itemReview: itemReview,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),

              // Form Name and Review
              Column(
                children: [
                  CustomTextFieldBg(
                    title: 'Nama',
                    hintText: 'Masukkan nama anda...',
                    textEditingController: nameController,
                    borderColor: TypografyStyle.mainColor,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Form tidak boleh kosong.';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextFieldBg(
                    title: 'Review',
                    hintText: 'Masukkan review anda...',
                    borderColor: TypografyStyle.mainColor,
                    textEditingController: reviewController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Form tidak boleh kosong.';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // Button Add Review
                  Consumer<RestaurantAddReviewProvider>(
                    builder: (context, state, child) {
                      if (state.resultState
                          is RestaurantAddReviewLoadingState) {
                        return const CircularProgres();
                      }

                      if (state.resultState
                          is RestaurantAddReviewFailureState) {
                        final failurState = state.resultState
                            as RestaurantAddReviewFailureState;
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            state.resetState();
                            nameController.clear();
                            reviewController.clear();
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return PopScope(
                                  canPop: false,
                                  child: InfoDialog(
                                    titleButton: 'Kembali',
                                    message: failurState.message,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }

                      if (state.resultState is RestaurantAddReviewLoadedState) {
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            state.resetState();
                            nameController.clear();
                            reviewController.clear();
                            context
                                .read<RestaurantDetailProvider>()
                                .fetchRestaurantDetail(widget.restaurntId);
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return PopScope(
                                  canPop: false,
                                  child: InfoDialog(
                                    titleButton: 'Kembali',
                                    message: 'Berhasil menambahkan review.',
                                    iconDialog: UniconsLine.check_circle,
                                    colorIconDialog: Colors.green,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }

                      return CustomButton(
                        backgroundColor: TypografyStyle.mainColor,
                        colorTitle: TypografyStyle.whiteColor,
                        title: 'Tambahkan Review',
                        onTap: () {
                          if (!formKey.currentState!.validate()) {
                          } else {
                            context
                                .read<RestaurantAddReviewProvider>()
                                .addReviews(
                                  ReviewRequestModel(
                                    id: restaurant.id,
                                    name: nameController.text,
                                    review: reviewController.text,
                                  ),
                                );
                          }
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
