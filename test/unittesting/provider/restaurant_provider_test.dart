import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_list_model.dart';
import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_model.dart';
import 'package:restaurant_app/data/services/restaurant_services.dart';
import 'package:restaurant_app/data/static/restaurant_list_state.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';

class MockClient extends Mock implements http.Client {}

class MockRestaurantServices extends Mock implements RestaurantServices {}

void main() {
  late MockRestaurantServices mockRestaurantServices;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    mockRestaurantServices = MockRestaurantServices();
    restaurantListProvider = RestaurantListProvider(mockRestaurantServices);
  });

  group('RestaurantListProvider', () {
    test('RestaurantListNoneState',
        () {
      final initState = restaurantListProvider.resultState;

      expect(initState, isA<RestaurantListNoneState>());
    });

    test(
        ' RestaurantListLoadingState',
        () async {
      when(() => mockRestaurantServices.getListRestaurant())
          .thenAnswer((_) async => RestaurantListModel(
                error: false,
                message: 'success',
                count: 1,
                restaurnts: [
                  RestaurantModel(
                    id: '1',
                    name: 'Test Restaurant',
                    description: 'Description',
                    pictureId: '1',
                    city: 'Test City',
                    rating: 4.5,
                  ),
                ],
              ));

      final future = restaurantListProvider.fetchRestaurantList();

      expect(restaurantListProvider.resultState,
          isA<RestaurantListLoadingState>());

      await future;
    });

    test('RestaurantListLoadedState', () async {
      when(() => mockRestaurantServices.getListRestaurant())
          .thenAnswer((_) async => RestaurantListModel(
                error: false,
                message: 'success',
                count: 1,
                restaurnts: [
                  RestaurantModel(
                    id: '1',
                    name: 'Test Restaurant',
                    description: 'Description',
                    pictureId: '1',
                    city: 'Test City',
                    rating: 4.5,
                  ),
                ],
              ));

      await restaurantListProvider.fetchRestaurantList();

      expect(
          restaurantListProvider.resultState, isA<RestaurantListLoadedState>());
      final state =
          restaurantListProvider.resultState as RestaurantListLoadedState;
      expect(state.data.first.name, 'Test Restaurant');
    });

    test('RestaurantListFailureState', () async {
      when(() => mockRestaurantServices.getListRestaurant())
          .thenThrow(Exception('Failed to load restaurant list'));

      await restaurantListProvider.fetchRestaurantList();

      expect(restaurantListProvider.resultState,
          isA<RestaurantListFailureState>());
      final state =
          restaurantListProvider.resultState as RestaurantListFailureState;
      expect(state.message, contains('Failed to load restaurant list'));
    });
  });
}
