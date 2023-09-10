enum NetworkEnums {
  login('auth/login'),
  register('auth/register'),
  introOff('introOff'),
  token('token');

  final String path;
  const NetworkEnums(this.path);
}
