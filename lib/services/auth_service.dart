import 'package:firebase_auth/firebase_auth.dart';

/// Firebase Authentication service handling Sign In, Sign Up, and Sign Out operations.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Stream of user authentication state.
  Stream<User?> get userStream => _auth.authStateChanges();

  /// Gets the currently authenticated user.
  User? get currentUser => _auth.currentUser;

  /// Sign in with email and password.
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('An unexpected authentication error occurred.');
    }
  }

  /// Create a new account with email and password.
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('An unexpected registration error occurred.');
    }
  }

  /// Sign out current user.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Maps Firebase Auth exception codes to user-friendly error messages.
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'invalid-email':
        return 'Please provide a valid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters long.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'invalid-credential':
        return 'Invalid email or password credentials.';
      default:
        return e.message ?? 'Authentication failed.';
    }
  }
}
