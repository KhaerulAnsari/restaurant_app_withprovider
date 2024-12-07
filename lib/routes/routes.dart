enum Routes {
  mainRoute("/main"),
  detailRoute("/detail"),
  searchRestaurantRoute("/searchRestaurant");

  const Routes(this.name);
  final String name;
}
