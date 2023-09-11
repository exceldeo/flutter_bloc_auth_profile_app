import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioManager {
  static DioManager? _instance;

  static DioManager get instance {
    if (_instance != null) return _instance!;
    _instance = DioManager();
    return _instance!;
  }

  final String _baseUrl = dotenv.env['CLIENT_URL']!;
  late final Dio dio;

  DioManager() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        followRedirects: true,
      ),
    );
  }
}
