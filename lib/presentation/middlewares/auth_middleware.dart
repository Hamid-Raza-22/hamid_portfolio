import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

/// Middleware to protect admin routes from unauthenticated access.
/// Redirects to the login page if the user is not authenticated.
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;
    if (!isAuthenticated) {
      return const RouteSettings(name: AppRoutes.adminLogin);
    }
    return null;
  }
}
