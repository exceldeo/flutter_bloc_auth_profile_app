import 'package:my_profile_app/core/base/profile/model/profile_model.dart';
import 'package:my_profile_app/core/init/network/dio_manager.dart';

abstract class IProfileService {
  final DioManager dioManager;

  IProfileService(this.dioManager);

  Future<ProfileModel?> getProfile();

  Future<ProfileModel?> updateProfile({
    String? name,
    String? birthday,
    int? height,
    int? weight,
    List<String>? interests,
  });

  Future<ProfileModel?> createProfile({
    required String name,
    required String birthday,
    required int height,
    required int weight,
    required List<String> interests,
  });
}
