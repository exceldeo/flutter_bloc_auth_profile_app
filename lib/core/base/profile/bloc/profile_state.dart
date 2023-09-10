part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final ProfileModel? profile;
  final bool isLoading;
  final AuthError? error;

  const ProfileState._({
    this.profile,
    this.isLoading = false,
    this.error,
  });

  const ProfileState.unknown() : this._();

  const ProfileState.error({AuthError error = AuthError.unknown})
      : this._(isLoading: false, error: error);

  const ProfileState.loading() : this._(isLoading: true);

  const ProfileState.loaded(ProfileModel profile)
      : this._(profile: profile, isLoading: false);

  @override
  List<Object?> get props => [profile, isLoading, error];
}
