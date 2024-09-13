class ApiResponse<T> {
  final String message;
  final bool success;
  final T? data;

  ApiResponse({required this.message, required this.success, this.data});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json)? fromJsonT) {
    return ApiResponse(
        message: json['message'] as String,
        success: json['success'] as bool,
        data: json['data'] != null ? fromJsonT!(json['data']) : null);
  }
}
