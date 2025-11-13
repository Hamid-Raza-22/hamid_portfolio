import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../widgets/app_navbar.dart';
import '../controllers/contact_controller.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [AppColors.surfaceDark, AppColors.scaffoldBg, Colors.black],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const AppNavbar(),
                SizedBox(height: ResponsiveUtils.getSpacing(context, multiplier: 2)),
                Container(
                  constraints: BoxConstraints(maxWidth: 800),
                  padding: ResponsiveUtils.responsivePadding(context),
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [AppColors.textPrimary, AppColors.primary, AppColors.neonBlue],
                        ).createShader(bounds),
                        child: Text(
                          'Get In Touch',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.responsiveFontSize(context, mobile: 32, desktop: 48),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, multiplier: 2)),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            _buildTextField('Name', controller.nameController, Icons.person),
                            const SizedBox(height: 20),
                            _buildTextField('Email', controller.emailController, Icons.email),
                            const SizedBox(height: 20),
                            _buildTextField('Subject', controller.subjectController, Icons.subject),
                            const SizedBox(height: 20),
                            _buildTextField('Message', controller.messageController, Icons.message, maxLines: 5),
                            const SizedBox(height: 30),
                            Obx(() => ElevatedButton(
                                  onPressed: controller.isSending.value ? null : controller.sendMessage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: controller.isSending.value
                                      ? const CircularProgressIndicator(color: Colors.black)
                                      : const Text('Send Message', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController ctrl, IconData icon, {int maxLines = 1}) {
    return TextFormField(
      controller: ctrl,
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSecondary),
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.cardBg.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderSecondary.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderSecondary.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? 'This field is required' : null,
    );
  }
}
