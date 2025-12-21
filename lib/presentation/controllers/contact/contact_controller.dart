import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/stream/stream_usecases.dart';

/// Controller for Contact page following MVVM pattern.
/// Uses Firebase real-time streams for live updates.
class ContactController extends GetxController {
  final WatchContactInfoUseCase _watchContactInfoUseCase;
  final WatchSocialLinksUseCase _watchSocialLinksUseCase;

  ContactController({
    required WatchContactInfoUseCase watchContactInfoUseCase,
    required WatchSocialLinksUseCase watchSocialLinksUseCase,
  })  : _watchContactInfoUseCase = watchContactInfoUseCase,
        _watchSocialLinksUseCase = watchSocialLinksUseCase;

  final List<StreamSubscription> _subscriptions = [];

  // Observable State
  final isLoading = true.obs;
  final contactInfo = <ContactInfoEntity>[].obs;
  final socialLinks = <SocialLinkEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _subscribeToStreams();
  }

  void _subscribeToStreams() {
    isLoading.value = true;

    _subscriptions.addAll([
      _watchContactInfoUseCase().listen(
        (data) {
          contactInfo.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching contact info: $e'),
      ),
      _watchSocialLinksUseCase().listen(
        (data) {
          socialLinks.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching social links: $e'),
      ),
    ]);
  }

  void _checkLoadingComplete() {
    if (isLoading.value) {
      isLoading.value = false;
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

  @override
  void onClose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    super.onClose();
  }
}
