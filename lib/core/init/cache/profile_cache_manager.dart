import 'package:my_profile_app/core/base/profile/model/profile_model.dart';

import '../../constants/enums/network_enums.dart';
import 'cache_manager.dart';

class ProfileCacheManager {
  Future<ProfileModel?> getProfile() async {
    final response = await CacheManager.getString(NetworkEnums.profile.path);
    if (response != null) {
      return ProfileModel.fromJson(response as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<void> updateProfile(ProfileModel profileModel) async {
    await CacheManager.setString(
        NetworkEnums.profile.path, profileModel.toJson() as String);
  }
}
