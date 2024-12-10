class MyAppFirebaseAuthException implements Exception {
  final String code;

  MyAppFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please check the code and try again.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please try again later.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'requires-recent-login':
        return 'Recent login required. Please log in again.';
      case 'account-exists-with-different-credential':
        return 'Account already exists with a different credential.';
      case 'invalid-credential':
        return 'Invalid credential. Please check your credentials and try again.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please check and try again.';
      case 'invalid-phone-number':
        return 'The provided phone number is not valid. Please enter a valid phone number.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'session-expired':
        return 'The session has expired. Please try the action again.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication. Please contact support.';
      case 'quota-exceeded':
        return 'Quota exceeded for this project. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'missing-verification-code':
        return 'Verification code is missing. Please provide the code to continue.';
      case 'missing-verification-id':
        return 'Verification ID is missing. Please try the action again.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new one and try again.';
      case 'invalid-action-code':
        return 'The action code provided is invalid. Please check and try again.';
      case 'invalid-password':
        return 'The password is invalid. Please try again.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'email-change-needs-verification':
        return 'Email change needs verification. Please verify your email to continue.';
      case 'app-deleted':
        return 'The app associated with this request has been deleted.';
      default:
        return 'An error occurred. Please try again later.';
    }
  }
}
