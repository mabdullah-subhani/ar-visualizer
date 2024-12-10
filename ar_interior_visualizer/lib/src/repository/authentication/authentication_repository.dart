import 'package:ar_interior_visualizer/navigation_menu.dart';
import 'package:ar_interior_visualizer/src/features/authentication/screens/login/login_screen.dart';
import 'package:ar_interior_visualizer/src/features/authentication/screens/signup/verify_email.dart';
import 'package:ar_interior_visualizer/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:ar_interior_visualizer/src/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../exceptions/firebase_auth_exceptions.dart';
import '../../exceptions/firebase_exception.dart';
import '../../exceptions/format_exception.dart';
import '../../exceptions/platform_exception.dart';
import '../../features/authentication/screens/onboarding/onboarding.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  /// Get Authentication User Data
  User? get authUser => _auth.currentUser;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();

  }

  /// Function to show Relevant Screen & Redirect Accordingly
  screenRedirect() async {
    final user=_auth.currentUser;

    if (user != null) {
      /// If the user id logged in
      if (user.emailVerified) {

        /// Initialize User Specific Storage
        await MyAppLocalStorage.init(user.uid);

        /// If the user's email is verified, navigate to the main Navigation Menu
        Get.offAll(() => const NavigationMenu());
      } else {
        /// If the user's email isn't verified, navigate to the main VerifyEmailScreen
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      /// Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      /// Check if it's the first time the app is launched
      if (deviceStorage.read('isFirstTime') != true) {
        /// If it's not the first time, navigate to the LoginScreen
        Get.offAll(() => const WelcomeScreen());
      } else {
       /// If it's the first time, navigate to the OnBoardingScreen
        Get.offAll(() => const OnBoardingScreen());
      }
    }
  }

  /* ------------------------------  Email & Password Sign-In ---------------------------------- */

  /// [EmailAuthentication] - LOGIN

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  /// [EmailAuthentication] - REGISTER

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - FORGOT PASSWORD

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ReAuthenticate] - Re-AUTHENTICATE USER
  Future<void>  reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // Re-authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


/* ------------------------------  Federated Identity & Social Sign-In ---------------------------------- */

/// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a new credentials
      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once signed in, return the User Credentials
      return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      if(kDebugMode) print('Something went wrong:  $e');
      return null;
    }
  }


/* ------------------------------  ./end Federated Identity & Social Sign-In ---------------------------------- */

  /// [LogoutUser] - Valid for any Authentication

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [DeleteUser] - Remove User Auth and Firestore Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}


