class ApiConstants {
  static const connectionTimeOut = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 30);
  static const sendTimeout = Duration(seconds: 30);

  static const int maxRetries = 3;
  static const List<Duration> retryDelays = [
    Duration(seconds: 1),
    Duration(seconds: 5),
    Duration(seconds: 15)
  ];

  static const paginationLimit = 10;

  static const baseUrl = "https://dummyjson.com";
  static const String productEndPoint = "/products";
}
