import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:my_profile_app/data/models/user.dart';

class UserRepository {
  final Dio dio;
  UserRepository(this.dio);

  Future<User?> getUser() async {
    try {
      final response = await dio.get('/api/user'); // Ganti dengan URL API yang sesuai
      if (response.statusCode == 200) {
        final userJson = json.decode(response.data);
        return User.fromJson(userJson);
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }

  Future<bool> updateUser(User user) async {
    try {
      final userJson = user.toJson();
      final response = await dio.put('/api/user/${user.id}', data: userJson); // Ganti dengan URL API yang sesuai
      return response.statusCode == 200;
    } catch (e) {
      // Handle error
      return false;
    }
  }




  isSignedIn() {}
}