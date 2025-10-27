class RetryLogic {
  static const retryableErrorMessages = [
    'Connection Timeout.!',
    "Connection Error",
    'Unknown Network Error',
    'No internet',
    'SocketException',
    'Network is unreachable',
    "500: Internal Server Error",
    "503: Service Unavailable",
  ];

  static const noInternet = 'Internet Connection Problem';

  static bool isRetryable(String errorMessage) {
    return retryableErrorMessages.any((err) => errorMessage.contains(err));
  }

  static bool isInternetConnectionProblem(String errorMeassage) {
    return errorMeassage == noInternet;
  }
}
