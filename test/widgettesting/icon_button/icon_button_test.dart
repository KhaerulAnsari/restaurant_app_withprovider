import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/restaurant_list_model/restaurant_model.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';
import 'package:restaurant_app/screens/favorite/favorite_icon_button.dart';

class MockLocalDatabaseProvider extends Mock implements LocalDatabaseProvider {}

void main() {
  late MockLocalDatabaseProvider mockLocalDatabaseProvider;

  setUp(() {
    mockLocalDatabaseProvider = MockLocalDatabaseProvider();
  });

  Widget createWidgetUnderTest(RestaurantModel restaurant) {
    return ChangeNotifierProvider<LocalDatabaseProvider>(
      create: (_) => mockLocalDatabaseProvider,
      child: MaterialApp(
        home: Scaffold(
          body: FavoriteIconButton(
            restaurant: restaurant,
            sizeIcon: 32,
          ),
        ),
      ),
    );
  }

  testWidgets(
      'favorite_border icon',
      (WidgetTester tester) async {
    final restaurant = RestaurantModel(
      id: '1',
      name: 'Test Restaurant',
      description: 'Description',
      pictureId: '1',
      city: 'Test City',
      rating: 4.5,
    );

    when(() => mockLocalDatabaseProvider.loadRestaurantById('1'))
        .thenAnswer((_) async {});
    when(() => mockLocalDatabaseProvider.checkItemFavorite('1'))
        .thenReturn(false);

    await tester.pumpWidget(createWidgetUnderTest(restaurant));
    await tester.pump();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });

  testWidgets('favorite icon',
      (WidgetTester tester) async {
    final restaurant = RestaurantModel(
      id: '1',
      name: 'Test Restaurant',
      description: 'Description',
      pictureId: '1',
      city: 'Test City',
      rating: 4.5,
    );

    when(() => mockLocalDatabaseProvider.loadRestaurantById('1'))
        .thenAnswer((_) async {});
    when(() => mockLocalDatabaseProvider.checkItemFavorite('1'))
        .thenReturn(true);

    await tester.pumpWidget(createWidgetUnderTest(restaurant));
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('favorite state when icon is tapped',
      (WidgetTester tester) async {
    final restaurant = RestaurantModel(
      id: '1',
      name: 'Test Restaurant',
      description: 'Description',
      pictureId: '1',
      city: 'Test City',
      rating: 4.5,
    );

    when(() => mockLocalDatabaseProvider.loadRestaurantById('1'))
        .thenAnswer((_) async {});
    when(() => mockLocalDatabaseProvider.checkItemFavorite('1'))
        .thenReturn(false);
    when(() => mockLocalDatabaseProvider.saveRestaurant(restaurant))
        .thenAnswer((_) async {});
    when(() => mockLocalDatabaseProvider.removeRestaurantById('1'))
        .thenAnswer((_) async {});
    when(() => mockLocalDatabaseProvider.loadAllRestaurant())
        .thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest(restaurant));
    await tester.pump();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    verify(() => mockLocalDatabaseProvider.saveRestaurant(restaurant))
        .called(1);

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    verify(() => mockLocalDatabaseProvider.removeRestaurantById('1')).called(1);
  });
}
