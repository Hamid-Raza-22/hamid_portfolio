import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/app_bindings.dart';
import 'core/theme/app_theme.dart';
import 'models/home/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hamid Raza',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      theme: AppTheme.darkTheme,
      home: const HomeView(),
    );
  }
}