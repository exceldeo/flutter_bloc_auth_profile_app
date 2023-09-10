import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_app/core/constants/enums/auth_enums.dart';
import 'package:my_profile_app/core/init/cache/profile_cache_manager.dart';
import '../model/profile_model.dart';
import '../service/interface_profile_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IProfileService profileService;
  final ProfileCacheManager profileCacheManager;

  ProfileBloc(this.profileService, this.profileCacheManager)
      : super(const ProfileState.unknown()) {
    on<ProfileRequested>((event, emit) async {
      try {
        final ProfileModel? response = await profileService.getProfile();
        if (response != null) {
          await profileCacheManager.updateProfile(response);
          emit(ProfileState.loaded(response));
        } else {
          emit(const ProfileState.error(error: AuthError.profileNotFound));
        }
      } on SocketException {
        emit(const ProfileState.error(error: AuthError.hostUnreachable));
      } catch (e) {
        log(e.toString());
        emit(const ProfileState.error(error: AuthError.unknown));
      }
    });

    on<ProfileCreated>((event, emit) async {
      try {
        final ProfileModel? response = await profileService.createProfile(
          name: event.name,
          birthday: event.birthday,
          height: event.height,
          weight: event.weight,
          interests: event.interests ?? [],
        );
        if (response != null) {
          await profileCacheManager.updateProfile(response);
          emit(ProfileState.loaded(response));
        } else {
          emit(const ProfileState.error(error: AuthError.profileNotFound));
        }
      } on SocketException {
        emit(const ProfileState.error(error: AuthError.hostUnreachable));
      } catch (e) {
        log(e.toString());
        emit(const ProfileState.error(error: AuthError.unknown));
      }
    });

    on<ProfileUpdated>((event, emit) async {
      try {
        final ProfileModel? response = await profileService.updateProfile(
          name: event.name,
          birthday: event.birthday,
          height: event.height,
          weight: event.weight,
          interests: event.interests,
        );
        if (response != null) {
          await profileCacheManager.updateProfile(response);
          emit(ProfileState.loaded(response));
        } else {
          emit(const ProfileState.error(error: AuthError.profileNotFound));
        }
      } on SocketException {
        emit(const ProfileState.error(error: AuthError.hostUnreachable));
      } catch (e) {
        log(e.toString());
        emit(const ProfileState.error(error: AuthError.unknown));
      }
    });
  }
}
