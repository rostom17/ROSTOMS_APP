class RetryLogic {
  static const retryableErrorMessages = [
    'Internet Connection Problem'
    'Connection Timeout.!',
    'Connection Error',
    'Unknown Network Error',
    'No internet',
    'SocketException',
    'Network is unreachable',
    '500: Internal Server Error',
    '503: Service Unavailable',
  ];

  static bool isRetryable(String errorMessage) {
    return retryableErrorMessages.any((err) => errorMessage.contains(err));
  }
}
