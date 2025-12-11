import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

/// Controller for Contact page following MVVM pattern.
class ContactController extends GetxController {
  final GetContactInfoUseCase _getContactInfoUseCase;
  final GetSocialLinksUseCase _getSocialLinksUseCase;

  ContactController({
    required GetContactInfoUseCase getContactInfoUseCase,
    required GetSocialLinksUseCase getSocialLinksUseCase,
  })  : _getContactInfoUseCase = getContactInfoUseCase,
        _getSocialLinksUseCase = getSocialLinksUseCase;

  // Observable State
  final isLoading = true.obs;
  final contactInfo = <ContactInfoEntity>[].obs;
  final socialLinks = <SocialLinkEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      isLoading.value = true;

      final results = await Future.wait([
        _getContactInfoUseCase(),
        _getSocialLinksUseCase(),
      ]);

      contactInfo.value = results[0] as List<ContactInfoEntity>;
      socialLinks.value = results[1] as List<SocialLinkEntity>;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error loading contact data: $e');
    }
  }

  void goBack() => Get.back();

  Future<void> handleContactAction(String actionType, String value) async {
    switch (actionType) {
      case 'email':
        await launchEmail();
        break;
      case 'phone':
        await launchUrl(Uri.parse('tel:${value.replaceAll('-', '')}'));
        break;
      case 'whatsapp':
        await launchUrl(Uri.parse(
          'https://wa.me/${value.replaceAll('-', '').replaceAll('+', '')}',
        ));
        break;
      case 'location':
        await launchUrl(Uri.parse(
          'https://maps.google.com/?q=Johar+Town+Lahore+Pakistan',
        ));
        break;
    }
  }

  Future<void> launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'hamidraza.engr@gmail.com',
      queryParameters: {
        'subject': 'Project Inquiry',
        'body': 'Hi Hamid,\n\nI would like to discuss a project with you.',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> launchSocialUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
