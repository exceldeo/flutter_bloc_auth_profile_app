enum NetworkEnums {
  login('auth/login'),
  register('auth/register'),
  getProfile('users/getProfile'),
  createProfile('users/createProfile'),
  updateProfile('users/updateProfile'),
  introOff('introOff'),
  token('token'),
  username('username'),
  profile('profile');

  final String path;
  const NetworkEnums(this.path);
}
