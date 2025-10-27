class NetworkResponseModel {
  final int? statusCode;
  final String message;
  final dynamic body;

  const NetworkResponseModel({
     this.statusCode,
    required this.message,
    this.body,
  });
}
