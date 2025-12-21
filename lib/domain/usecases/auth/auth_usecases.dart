import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';

/// Use case for signing in with email and password.
class SignInUseCase {
  final AuthRepository _repository;
  SignInUseCase(this._repository);
  Future<User?> call(String email, String password) => 
      _repository.signIn(email, password);
}

/// Use case for signing up with email and password.
class SignUpUseCase {
  final AuthRepository _repository;
  SignUpUseCase(this._repository);
  Future<User?> call(String email, String password) => 
      _repository.signUp(email, password);
}

/// Use case for signing out.
class SignOutUseCase {
  final AuthRepository _repository;
  SignOutUseCase(this._repository);
  Future<void> call() => _repository.signOut();
}

/// Use case for resetting password.
class ResetPasswordUseCase {
  final AuthRepository _repository;
  ResetPasswordUseCase(this._repository);
  Future<void> call(String email) => _repository.resetPassword(email);
}

/// Use case for getting current user.
class GetCurrentUserUseCase {
  final AuthRepository _repository;
  GetCurrentUserUseCase(this._repository);
  User? call() => _repository.currentUser;
}

/// Use case for watching auth state changes.
class WatchAuthStateUseCase {
  final AuthRepository _repository;
  WatchAuthStateUseCase(this._repository);
  Stream<User?> call() => _repository.authStateChanges;
}

/// Use case for checking if user is authenticated.
class IsAuthenticatedUseCase {
  final AuthRepository _repository;
  IsAuthenticatedUseCase(this._repository);
  bool call() => _repository.isAuthenticated;
}
