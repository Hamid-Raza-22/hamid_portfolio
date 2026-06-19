import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes/app_routes.dart';

/// Middleware to protect admin routes.
/// Redirects to login if user is not authenticated.
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    final user = FirebaseAuth.instance.currentUser;
    
    // If user is NOT authenticated and trying to access a protected route (like dashboard)
    if (user == null && route != AppRoutes.adminLogin) {
      return const RouteSettings(name: AppRoutes.adminLogin);
    }
    
    // If user IS authenticated and trying to access the login page
    if (user != null && route == AppRoutes.adminLogin) {
      return const RouteSettings(name: AppRoutes.adminDashboard);
    }

    return null;
  }
}
