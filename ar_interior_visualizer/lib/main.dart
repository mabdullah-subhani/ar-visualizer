import 'package:ar_interior_visualizer/src/repository/authentication/authentication_repository.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'firebase_options.dart';


/// -- Entry point of Flutter App
Future<void> main() async {

  /// -- Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// -- GetX Local Storage
      await GetStorage.init();

  /// -- Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// -- initialize Firebase & Authentication Repository
  // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  // .then((value) => Get.put(AuthenticationRepository()));   // Initialize Authentication Repository
  // await FirebaseAppCheck.instance.activate();//Activate Firebase App Check

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// Now that Firebase is initialized, you can safely initialize the AuthenticationRepository
  Get.put(AuthenticationRepository());

// Then, activate Firebase App Check
  await FirebaseAppCheck.instance.activate();

  runApp(const App());
}
