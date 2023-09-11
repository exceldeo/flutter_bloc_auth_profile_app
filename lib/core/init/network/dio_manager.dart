import 'package:dio/dio.dart';

class DioManager {
  static DioManager? _instance;

  static DioManager get instance {
    if (_instance != null) return _instance!;
    _instance = DioManager._init();
    return _instance!;
  }

  final String _baseUrl = 'https://e85e-118-99-107-197.ngrok-free.app/';
  late final Dio dio;

  DioManager._init() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        followRedirects: true,
      ),
    );
  }
}
