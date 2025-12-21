import 'package:firebase_auth/firebase_auth.dart';

/// Abstract repository interface for authentication.
abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  bool get isAuthenticated;
  
  Future<User?> signIn(String email, String password);
  Future<User?> signUp(String email, String password);
  Future<void> signOut();
  Future<void> resetPassword(String email);
}
