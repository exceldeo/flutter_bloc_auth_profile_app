import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:my_profile_app/core/base/profile/model/profile_model.dart';
import 'package:my_profile_app/core/base/profile/service/interface_profile_service.dart';
import 'package:my_profile_app/core/constants/enums/network_enums.dart';

class ProfileService extends IProfileService {
  ProfileService(super.dioManager);

  @override
  Future<ProfileModel?> createProfile(
      {required String name,
      required String birthday,
      required int height,
      required int weight,
      required List<String> interests}) async {
    try {
      final response = await dioManager.dio.post(
        NetworkEnums.createProfile.path,
        data: {
          "name": name,
          "birthday": birthday,
          "height": height,
          "weight": weight,
          "interests": interests,
        },
      );

      if (response.statusCode == HttpStatus.created) {
        return ProfileModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  @override
  Future<ProfileModel?> getProfile() async {
    try {
      final response = await dioManager.dio.get(
        NetworkEnums.profile.path,
      );

      if (response.statusCode == HttpStatus.ok) {
        return ProfileModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  @override
  Future<ProfileModel?> updateProfile(
      {String? name,
      String? birthday,
      int? height,
      int? weight,
      List<String>? interests}) async {
    try {
      final response = await dioManager.dio.put(
        NetworkEnums.updateProfile.path,
        data: {
          "name": name,
          "birthday": birthday,
          "height": height,
          "weight": weight,
          "interests": interests,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        return ProfileModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
