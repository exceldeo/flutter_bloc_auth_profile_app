part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileRequested extends ProfileEvent {}

class ProfileCreated extends ProfileEvent {
  final String name;
  final String birthday;
  final int height;
  final int weight;
  final List<String>? interests;

  const ProfileCreated(
      this.name, this.birthday, this.height, this.weight, this.interests);

  @override
  List<Object?> get props => [name, birthday, height, weight, interests];
}

class ProfileUpdated extends ProfileEvent {
  final String name;
  final String birthday;
  final int height;
  final int weight;
  final List<String> interests;

  const ProfileUpdated(
      this.name, this.birthday, this.height, this.weight, this.interests);

  @override
  List<Object?> get props => [name, birthday, height, weight, interests];
}
