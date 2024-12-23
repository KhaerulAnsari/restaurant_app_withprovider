enum Routes {
  mainRoute("/main"),
  homeRoute("/home"),
  detailRoute("/detail"),
  searchRestaurantRoute("/searchRestaurant"),
  settingRoute("/setting");

  const Routes(this.name);
  final String name;
}
