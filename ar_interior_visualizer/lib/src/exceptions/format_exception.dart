class MyAppFormatException implements Exception {
  const MyAppFormatException();

  String get message => 'Invalid data format.';
}