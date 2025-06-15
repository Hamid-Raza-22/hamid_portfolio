import 'package:flutter/material.dart';

class ServiceModel {
  final String title;
  final String description;
  final String icon;
  final Color color;

  ServiceModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  static List<ServiceModel> get services => [
    ServiceModel(
      title: 'Development',
      description: 'Create a platform with the best and coolest quality from us.',
      icon: 'assets/icons/code.svg',
      color: Colors.purple,
    ),
    ServiceModel(
      title: 'UI/UX Designer',
      description: 'We provide UI/UX Design services, and of course with the best quality',
      icon: 'assets/icons/design.svg',
      color: Colors.red,
    ),
    // Add more services as needed
  ];
}