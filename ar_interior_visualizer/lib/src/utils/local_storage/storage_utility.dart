import 'package:get_storage/get_storage.dart';

class MyAppLocalStorage {

  late final GetStorage _storage ;

  /// Singleton Instance
  static late final MyAppLocalStorage? _instance ;

  MyAppLocalStorage._internal();

  factory MyAppLocalStorage.instance() {
     _instance ??  MyAppLocalStorage._internal();
     return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = MyAppLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Generic method to remove data
  Future<void> removeData<T>(String key) {
    return _storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() {
    return _storage.erase();
  }
}

// /// --********** Example of using LocalStorage **********--
//
// // Initialize LocalStorage
// LocalStorage localStorage = LocalStorage();
//
// // Save data to local storage
// localStorage.saveData('username', 'JohnDoe');
//
// // Read data from local storage
// String? username = localStorage.readData<String>('username');
// print('Username: $username'); // Output: Username: JohnDoe
//
// // Remove a specific data item
// localStorage.removeData('username');
//
// // Clear all stored data
// localStorage.clearAll();