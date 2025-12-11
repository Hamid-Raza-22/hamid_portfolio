import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/responsive_constants.dart';
import '../../controllers/contact/contact_controller.dart';
import '../../widgets/common/common_widgets.dart';

/// Contact page - dedicated page for contact information.
/// UI remains unchanged, logic moved to ContactController.
class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const GradientText(
          text: 'Contact',
          colors: [Colors.white, AppColors.primaryLight],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.8,
            colors: [
              Color(0xFF0F172A),
              Color(0xFF0C4A6E),
              AppColors.scaffoldBg,
            ],
            stops: [0.0, 0.35, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          padding: ResponsivePadding.all(context, multiplier: 1.5),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, tablet: 30, desktop: 40)),
                  _buildHeader(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, tablet: 50, desktop: 60)),
                  _buildContactCards(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, tablet: 50, desktop: 60)),
                  _buildSocialLinks(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, tablet: 50, desktop: 60)),
                  _buildContactForm(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, tablet: 30, desktop: 40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        SectionBadge(
          text: 'GET IN TOUCH',
          color: AppColors.accent,
          leadingWidget: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(height: 24),
        GradientText(
          text: "Let's Build Something\nAmazing Together",
          colors: const [Colors.white, AppColors.primaryLight],
          style: TextStyle(
            fontSize: ResponsiveValue.get<double>(context, mobile: 32, desktop: 48),
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 500),
          child: Text(
            'Have a project in mind? I\'d love to hear about it. Let\'s discuss how we can work together to bring your vision to life.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveValue.get<double>(context, mobile: 15, desktop: 16),
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactCards(BuildContext context) {
    return Obx(() => Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: controller.contactInfo.map((info) => _buildContactCard(
        context,
        icon: info.icon,
        title: info.title,
        value: info.value,
        color: info.color,
        action: info.actionType,
      )).toList(),
    ));
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Obx(() => Column(
      children: [
        const Text(
          'Connect With Me',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: controller.socialLinks.map((social) => _buildSocialCard(
            context,
            icon: social.icon,
            title: social.name,
            value: social.name,
            url: social.url,
            color: social.name == 'GitHub' ? Colors.white : const Color(0xFF0A66C2),
          )).toList(),
        ),
      ],
    ));
  }

  Widget _buildSocialCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String url,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => controller.launchSocialUrl(url),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 250),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        color: color,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required String action,
  }) {
    return GestureDetector(
      onTap: () => _handleContactAction(action, value),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: ResponsiveValue.get<double>(
              context, 
              mobile: double.infinity, 
              smallTablet: 280,
              tablet: 260,
              desktop: 260,
            ),
            padding: EdgeInsets.all(ResponsiveValue.get<double>(context, mobile: 16, tablet: 20, desktop: 24)),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 32),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleContactAction(String action, String value) {
    controller.handleContactAction(action, value);
  }

  Widget _buildContactForm(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: ResponsiveValue.get<double>(context, mobile: double.infinity, smallTablet: 450, tablet: 520, desktop: 600),
          padding: EdgeInsets.all(ResponsiveValue.get<double>(context, mobile: 20, tablet: 28, desktop: 40)),
          decoration: BoxDecoration(
            color: AppColors.cardBg.withOpacity(0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Send a Message',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField('Name', Icons.person_outline_rounded),
              const SizedBox(height: 16),
              _buildTextField('Email', Icons.email_outlined),
              const SizedBox(height: 16),
              _buildTextField('Subject', Icons.subject_rounded),
              const SizedBox(height: 16),
              _buildTextField('Message', Icons.message_outlined, maxLines: 5),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: AnimatedButton(
                  text: 'Send Message',
                  icon: Icons.send_rounded,
                  isPrimary: true,
                  onTap: () => controller.launchEmail(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.7)),
        prefixIcon: maxLines == 1 ? Icon(icon, color: AppColors.textSecondary) : null,
        filled: true,
        fillColor: AppColors.scaffoldBg.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
