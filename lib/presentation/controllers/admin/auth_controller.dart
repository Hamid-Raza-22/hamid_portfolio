import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/usecases/auth/auth_usecases.dart';
import '../../routes/app_routes.dart';

/// Auth Controller for handling authentication state and actions.
class AuthController extends GetxController {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final WatchAuthStateUseCase _watchAuthStateUseCase;
  final IsAuthenticatedUseCase _isAuthenticatedUseCase;

  AuthController({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required WatchAuthStateUseCase watchAuthStateUseCase,
    required IsAuthenticatedUseCase isAuthenticatedUseCase,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _signOutUseCase = signOutUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _watchAuthStateUseCase = watchAuthStateUseCase,
        _isAuthenticatedUseCase = isAuthenticatedUseCase;

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable state
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final errorMessage = ''.obs;
  final currentUser = Rxn<User>();
  final isSignUpMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _watchAuthState();
  }

  void _watchAuthState() {
    _watchAuthStateUseCase().listen((user) {
      currentUser.value = user;
    });
  }

  bool get isAuthenticated => _isAuthenticatedUseCase();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleSignUpMode() {
    isSignUpMode.value = !isSignUpMode.value;
    errorMessage.value = '';
    confirmPasswordController.clear();
  }

  Future<void> signIn() async {
    if (!_validateForm()) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _signInUseCase(
        emailController.text.trim(),
        passwordController.text,
      );

      _clearForm();
      Get.offAllNamed(AppRoutes.adminDashboard);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _getErrorMessage(e.code);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    if (!_validateSignUpForm()) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _signUpUseCase(
        emailController.text.trim(),
        passwordController.text,
      );

      _clearForm();
      Get.offAllNamed(AppRoutes.adminDashboard);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _getErrorMessage(e.code);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _signOutUseCase();
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign out. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      errorMessage.value = 'Please enter your email address';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _resetPasswordUseCase(email);

      Get.snackbar(
        'Success',
        'Password reset email sent. Check your inbox.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _getErrorMessage(e.code);
    } catch (e) {
      errorMessage.value = 'Failed to send reset email. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateForm() {
    if (emailController.text.trim().isEmpty) {
      errorMessage.value = 'Please enter your email';
      return false;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      errorMessage.value = 'Please enter a valid email';
      return false;
    }
    if (passwordController.text.isEmpty) {
      errorMessage.value = 'Please enter your password';
      return false;
    }
    if (passwordController.text.length < 6) {
      errorMessage.value = 'Password must be at least 6 characters';
      return false;
    }
    return true;
  }

  bool _validateSignUpForm() {
    if (!_validateForm()) return false;

    if (confirmPasswordController.text != passwordController.text) {
      errorMessage.value = 'Passwords do not match';
      return false;
    }
    return true;
  }

  void _clearForm() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    errorMessage.value = '';
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'Email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'invalid-credential':
        return 'Invalid email or password';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
