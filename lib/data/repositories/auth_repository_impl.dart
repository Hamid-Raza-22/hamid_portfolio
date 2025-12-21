import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_datasource.dart';

/// Implementation of AuthRepository.
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl({required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;

  @override
  Stream<User?> get authStateChanges => _authDataSource.authStateChanges;

  @override
  User? get currentUser => _authDataSource.currentUser;

  @override
  bool get isAuthenticated => _authDataSource.isAuthenticated;

  @override
  Future<User?> signIn(String email, String password) async {
    final result = await _authDataSource.signInWithEmailAndPassword(email, password);
    return result.user;
  }

  @override
  Future<User?> signUp(String email, String password) async {
    final result = await _authDataSource.createUserWithEmailAndPassword(email, password);
    return result.user;
  }

  @override
  Future<void> signOut() async {
    await _authDataSource.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _authDataSource.sendPasswordResetEmail(email);
  }
}
