import 'package:dio/dio.dart';

class DioUtil {
  static Dio? _dio;
  static const String baseUrl = 'http://localhost:3000';

  static Dio get dio {
    _dio ??= Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout:
          Duration(seconds: 5000), // Sesuaikan dengan kebutuhan Anda
      receiveTimeout:
          Duration(seconds: 3000), // Sesuaikan dengan kebutuhan Anda
    ));
    return _dio!;
  }

  static Future<Response> post(String path, dynamic data) async {
    final Response response = await dio.post(path, data: data);
    return response;
  }

  static Future<Response> get(String path) async {
    final Response response = await dio.get(path);
    return response;
  }
}
