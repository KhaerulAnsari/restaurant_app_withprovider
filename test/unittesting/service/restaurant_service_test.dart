import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_list_model.dart';
import 'package:restaurant_app/data/services/restaurant_services.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri());
  });

  group('RestaurantServices', () {
    late RestaurantServices restaurantServices;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      restaurantServices = RestaurantServices(client: mockClient);
    });

    test('Get Succes Restaurant', () async {
      const sampleResponse = '''{
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      }''';

      when(() => mockClient.get(any()))
          .thenAnswer((_) async => http.Response(sampleResponse, 200));

      final response = await restaurantServices.getListRestaurant();

      expect(response, isA<RestaurantListModel>());
      expect(response.restaurnts!.first.name, "Melting Pot");
    });

    test('Get Failure Restaurant', () async {
      when(() => mockClient.get(any()))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() async => await restaurantServices.getListRestaurant(),
          throwsA(isA<Exception>()));
    });
  });
}
