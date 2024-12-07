import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/static/restaurant_list_search_state.dart';
import 'package:restaurant_app/provider/restaurant_list_search_provider.dart';
import 'package:restaurant_app/screens/home/card_list_restaurant.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';
import 'package:restaurant_app/style/widgets/circular_progres.dart';
import 'package:restaurant_app/style/widgets/custom_textfield_bg.dart';
import 'package:restaurant_app/style/widgets/info_dialog.dart';
import 'package:unicons/unicons.dart';

class SearchRestaurantScreen extends StatefulWidget {
  const SearchRestaurantScreen({super.key});

  @override
  State<SearchRestaurantScreen> createState() => _SearchRestaurantScreenState();
}

class _SearchRestaurantScreenState extends State<SearchRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      UniconsLine.arrow_left,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomTextFieldBg(
                      borderColor: TypografyStyle.mainColor,
                      hintText: 'Cari Restoran,menu atau kategori...',
                      onChanged: (value) {
                        if (value.isEmpty) {
                          context
                              .read<RestaurantListSearchProvider>()
                              .resetState();
                        } else {
                          context
                              .read<RestaurantListSearchProvider>()
                              .searchRestaurantList(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<RestaurantListSearchProvider>(
                builder: (context, state, child) {
                  if (state.resultState is RestaurantListSearchLoadingState) {
                    return const Expanded(
                      child: CircularProgres(),
                    );
                  }

                  if (state.resultState is RestaurantListSearchFailureState) {
                    final resultFailureState =
                        state.resultState as RestaurantListSearchFailureState;
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        state.resetState();
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return PopScope(
                              canPop: false,
                              child: InfoDialog(
                                titleButton: 'Kembali',
                                message: resultFailureState.message,
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

                  if (state.resultState is RestaurantListSearchLoadedState) {
                    final resultLoadedState =
                        state.resultState as RestaurantListSearchLoadedState;
                    return Expanded(
                      child: resultLoadedState.restaurants.isEmpty
                          ? const Center(
                              child: Text('Pencarian tidak ditemukan.'),
                            )
                          : ListView.builder(
                              itemCount: resultLoadedState.restaurants.length,
                              itemBuilder: (context, index) {
                                final restaurant =
                                    resultLoadedState.restaurants[index];
                                return CardListRestaurant(
                                  restaurant: restaurant,
                                );
                              },
                            ),
                    );
                  }

                  return const Expanded(
                    child: Center(
                      child: Text('Silahkan cari restaurant atau menu.'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
