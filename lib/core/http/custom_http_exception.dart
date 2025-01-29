class CustomHTTPException implements Exception {
  final int code;
  final String message;
  final String path;
  final dynamic data;
  final Map<String, dynamic>? headers;

  CustomHTTPException({
    required this.code,
    required this.message,
    required this.path,
    this.data,
    this.headers,
  });

  @override
  String toString() {
    return 'CustomHTTPException: $code $message\nPath: $path\nData: $data\nHeaders: $headers';
  }
}
