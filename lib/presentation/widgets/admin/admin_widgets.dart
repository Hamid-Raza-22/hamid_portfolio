import 'dart:typed_data';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/responsive_constants.dart';
import '../../../core/utils/icon_mapper.dart';
import '../../../core/utils/color_mapper.dart';
import '../../../data/datasources/remote/storage_datasource.dart';
import '../../../domain/entities/entities.dart';
import '../../controllers/admin/admin_dashboard_controller.dart';

// ============ BASE MANAGEMENT WIDGET ============

class BaseManagementWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onAdd;
  final Widget child;
  final bool isLoading;

  const BaseManagementWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onAdd,
    required this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 500;
        final padding = isNarrow ? 16.0 : 24.0;

        return Container(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isNarrow)
                _buildNarrowHeader()
              else
                _buildWideHeader(),
              const SizedBox(height: 24),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Expanded(child: child),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWideHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.primary, size: 28),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _buildAddButton(),
      ],
    );
  }

  Widget _buildNarrowHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: _buildAddButton()),
      ],
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton.icon(
      onPressed: onAdd,
      icon: const Icon(Icons.add, size: 20),
      label: const Text('Add New'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

// ============ ITEM CARD WIDGET ============

class AdminItemCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final List<Widget>? extraInfo;
  final String? customIconUrl;
  final bool useCustomImage;

  const AdminItemCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.color,
    required this.onEdit,
    required this.onDelete,
    this.extraInfo,
    this.customIconUrl,
    this.useCustomImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowCustomImage = useCustomImage && 
        customIconUrl != null && 
        customIconUrl!.isNotEmpty;

    return RepaintBoundary(
      child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          if (shouldShowCustomImage)
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (color ?? AppColors.primary).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      customIconUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(
                        icon ?? Icons.image,
                        color: color ?? AppColors.primary,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            )
          else if (icon != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (color ?? AppColors.primary).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color ?? AppColors.primary, size: 24),
            ),
          if (shouldShowCustomImage || icon != null) const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (useCustomImage)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Custom Image',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (extraInfo != null) ...extraInfo!,
              ],
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, color: AppColors.primary),
            tooltip: 'Edit',
          ),
          IconButton(
            onPressed: () => _showDeleteConfirm(context),
            icon: const Icon(Icons.delete, color: Colors.red),
            tooltip: 'Delete',
          ),
        ],
      ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Delete Item?', style: TextStyle(color: Colors.white)),
        content: Text(
          'Are you sure you want to delete "$title"? This action cannot be undone.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              onDelete();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ============ FORM DIALOG BASE ============

class AdminFormDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onSave;
  final bool isLoading;

  const AdminFormDialog({
    super.key,
    required this.title,
    required this.children,
    required this.onSave,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final maxW = (size.width * 0.95).clamp(320.0, 520.0);
    // Account for keyboard height in max height calculation
    final availableHeight = size.height - viewInsets.bottom;
    final maxH = (availableHeight * 0.85).clamp(300.0, 700.0);

    return Dialog(
      backgroundColor: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: viewInsets.bottom + 24,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxW, maxHeight: maxH),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: isLoading ? null : onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ FORM FIELD WIDGET ============

class AdminTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  final TextInputType? keyboardType;

  const AdminTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ============ ICON OR IMAGE PICKER ============

class IconPickerField extends StatefulWidget {
  final String label;
  final String selectedIcon;
  final ValueChanged<String> onChanged;
  final String? customIconUrl;
  final Function(String)? onCustomIconUploaded;
  final bool useCustomImage;
  final Function(bool)? onUseCustomImageChanged;

  const IconPickerField({
    super.key,
    required this.label,
    required this.selectedIcon,
    required this.onChanged,
    this.customIconUrl,
    this.onCustomIconUploaded,
    this.useCustomImage = false,
    this.onUseCustomImageChanged,
  });

  @override
  State<IconPickerField> createState() => _IconPickerFieldState();
}

class _IconPickerFieldState extends State<IconPickerField> {
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    final isCustomImage = widget.useCustomImage && widget.customIconUrl != null;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        // Toggle between Icon and Custom Image
        if (widget.onCustomIconUploaded != null) ...[
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => widget.onUseCustomImageChanged?.call(false),
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(7)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !widget.useCustomImage 
                              ? AppColors.primary.withOpacity(0.2) 
                              : Colors.transparent,
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(7)),
                          border: !widget.useCustomImage 
                              ? Border.all(color: AppColors.primary) 
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.widgets_rounded,
                              size: 18,
                              color: !widget.useCustomImage ? AppColors.primary : Colors.white54,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Default Icon',
                              style: TextStyle(
                                color: !widget.useCustomImage ? AppColors.primary : Colors.white54,
                                fontWeight: !widget.useCustomImage ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => widget.onUseCustomImageChanged?.call(true),
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(7)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: widget.useCustomImage 
                              ? AppColors.primary.withOpacity(0.2) 
                              : Colors.transparent,
                          borderRadius: const BorderRadius.horizontal(right: Radius.circular(7)),
                          border: widget.useCustomImage 
                              ? Border.all(color: AppColors.primary) 
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_rounded,
                              size: 18,
                              color: widget.useCustomImage ? AppColors.primary : Colors.white54,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Custom Image',
                              style: TextStyle(
                                color: widget.useCustomImage ? AppColors.primary : Colors.white54,
                                fontWeight: widget.useCustomImage ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        // Show Icon picker or Image uploader based on selection
        if (widget.useCustomImage)
          _buildImageUploader()
        else
          _buildIconSelector(isCustomImage),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImageUploader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          // Image preview
          if (widget.customIconUrl != null && widget.customIconUrl!.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Center(
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      widget.customIconUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.broken_image,
                        color: Colors.white30,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _isUploading ? null : _uploadCustomImage,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isUploading)
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      const Icon(Icons.cloud_upload, color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      _isUploading 
                          ? 'Uploading...' 
                          : (widget.customIconUrl != null ? 'Change Image' : 'Upload Image'),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Recommended: Square image (64x64 to 200x200 px)',
            style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildIconSelector(bool isCustomImage) {
    return InkWell(
      onTap: () => _showIconPicker(context),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Icon(IconMapper.fromString(widget.selectedIcon), color: AppColors.primary),
            const SizedBox(width: 12),
            Text(
              widget.selectedIcon,
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadCustomImage() async {
    if (widget.onCustomIconUploaded == null) return;
    
    try {
      setState(() => _isUploading = true);
      
      final Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();
      if (imageBytes == null) {
        setState(() => _isUploading = false);
        return;
      }

      final storage = Get.find<StorageDataSource>();
      final fileName = 'custom_image_${DateTime.now().millisecondsSinceEpoch}.png';
      
      final downloadUrl = await storage.uploadImage(
        imageBytes: imageBytes,
        path: 'custom_icons',
        fileName: fileName,
      );

      widget.onCustomIconUploaded!(downloadUrl);
      setState(() => _isUploading = false);
      Get.snackbar('Success', 'Custom image uploaded!',
          backgroundColor: AppColors.primary, colorText: Colors.white);
    } catch (e) {
      setState(() => _isUploading = false);
      Get.snackbar('Error', 'Failed to upload image: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void _showIconPicker(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = (size.width * 0.9).clamp(300.0, 480.0);
    final h = (size.height * 0.8).clamp(350.0, 500.0);
    final cols = (w / 60).floor().clamp(4, 8);

    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF1E293B),
        child: SizedBox(
          width: w,
          height: h,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Icon',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: IconMapper.availableIcons.length,
                  itemBuilder: (context, index) {
                    final iconName = IconMapper.availableIcons[index];
                    final isSelected = iconName == widget.selectedIcon;
                    return Tooltip(
                      message: iconName,
                      child: InkWell(
                        onTap: () {
                          widget.onChanged(iconName);
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: isSelected ? Border.all(color: AppColors.primary) : null,
                          ),
                          child: Icon(
                            IconMapper.fromString(iconName),
                            color: isSelected ? AppColors.primary : Colors.white70,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ COLOR PICKER ============

class ColorPickerField extends StatelessWidget {
  final String label;
  final String selectedColor;
  final ValueChanged<String> onChanged;

  const ColorPickerField({
    super.key,
    required this.label,
    required this.selectedColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _showColorPicker(context),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: ColorMapper.fromString(selectedColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Text(selectedColor, style: const TextStyle(color: Colors.white)),
                const Spacer(),
                const Icon(Icons.arrow_drop_down, color: Colors.white70),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showColorPicker(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = (size.width * 0.9).clamp(280.0, 420.0);
    final h = (size.height * 0.8).clamp(320.0, 450.0);
    final cols = (w / 56).floor().clamp(4, 7);

    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF1E293B),
        child: SizedBox(
          width: w,
          height: h,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Color',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: ColorMapper.availableColors.length,
                  itemBuilder: (context, index) {
                    final colorName = ColorMapper.availableColors[index];
                    final isSelected = colorName == selectedColor;
                    return InkWell(
                      onTap: () {
                        onChanged(colorName);
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorMapper.fromString(colorName),
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected
                              ? Border.all(color: Colors.white, width: 3)
                              : Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ TAGS EDITOR ============

class TagsEditorField extends StatefulWidget {
  final String label;
  final List<String> tags;
  final ValueChanged<List<String>> onChanged;

  const TagsEditorField({
    super.key,
    required this.label,
    required this.tags,
    required this.onChanged,
  });

  @override
  State<TagsEditorField> createState() => _TagsEditorFieldState();
}

class _TagsEditorFieldState extends State<TagsEditorField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...widget.tags.map((tag) => Chip(
                  label: Text(tag, style: const TextStyle(color: Colors.white)),
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  deleteIcon: const Icon(Icons.close, size: 16, color: Colors.white70),
                  onDeleted: () {
                    final newTags = List<String>.from(widget.tags)..remove(tag);
                    widget.onChanged(newTags);
                  },
                )),
            SizedBox(
              width: 120,
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Add tag...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  isDense: true,
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    final newTags = List<String>.from(widget.tags)..add(value);
                    widget.onChanged(newTags);
                    _controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ============ SKILLS EDITOR (for skills with icons) ============

class SkillsEditorField extends StatefulWidget {
  final String label;
  final List<SkillEntity> skillEntities;
  final ValueChanged<List<SkillEntity>> onChanged;

  const SkillsEditorField({
    super.key,
    required this.label,
    required this.skillEntities,
    required this.onChanged,
  });

  @override
  State<SkillsEditorField> createState() => _SkillsEditorFieldState();
}

class _SkillsEditorFieldState extends State<SkillsEditorField> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        ...widget.skillEntities.asMap().entries.map((entry) => _buildSkillItem(entry.key, entry.value)),
        _buildAddSkillRow(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSkillItem(int index, SkillEntity skill) {
    final hasCustomIcon = skill.useCustomImage && skill.customIconUrl != null;
    final hasIcon = skill.icon != null || hasCustomIcon;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: hasIcon ? AppColors.primary.withOpacity(0.3) : Colors.transparent),
      ),
      child: Row(
        children: [
          // Icon indicator
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: hasIcon ? AppColors.primary.withOpacity(0.15) : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: hasCustomIcon
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      skill.customIconUrl!,
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(
                        skill.icon ?? Icons.code,
                        color: AppColors.primary,
                        size: 16,
                      ),
                    ),
                  )
                : Icon(
                    skill.icon ?? Icons.circle,
                    color: hasIcon ? AppColors.primary : Colors.white30,
                    size: hasIcon ? 16 : 6,
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              skill.name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          // Edit icon button
          IconButton(
            icon: const Icon(Icons.edit, size: 16, color: AppColors.primary),
            onPressed: () => _showEditSkillDialog(index, skill),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            tooltip: 'Edit skill icon',
          ),
          const SizedBox(width: 8),
          // Delete button
          IconButton(
            icon: const Icon(Icons.close, size: 18, color: Colors.white70),
            onPressed: () {
              final newItems = List<SkillEntity>.from(widget.skillEntities)..removeAt(index);
              widget.onChanged(newItems);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddSkillRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Add skill name...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              isDense: true,
            ),
            onSubmitted: (_) => _addSkill(),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: _addSkill,
          icon: const Icon(Icons.add_circle, color: AppColors.primary),
          tooltip: 'Add skill',
        ),
      ],
    );
  }

  void _addSkill() {
    if (_nameController.text.isNotEmpty) {
      final newItems = List<SkillEntity>.from(widget.skillEntities)
        ..add(SkillEntity(name: _nameController.text));
      widget.onChanged(newItems);
      _nameController.clear();
    }
  }

  void _showEditSkillDialog(int index, SkillEntity skill) {
    final nameController = TextEditingController(text: skill.name);
    final selectedIcon = (skill.icon != null ? IconMapper.iconToString(skill.icon!) : 'code').obs;
    final customIconUrl = Rxn<String>(skill.customIconUrl);
    final useCustomImage = (skill.useCustomImage).obs;

    Get.dialog(
      Obx(() => AlertDialog(
        backgroundColor: AppColors.cardBg,
        title: const Text('Edit Skill', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AdminTextField(label: 'Skill Name', controller: nameController),
              IconPickerField(
                label: 'Skill Icon / Image (optional)',
                selectedIcon: selectedIcon.value,
                onChanged: (value) => selectedIcon.value = value,
                customIconUrl: customIconUrl.value,
                onCustomIconUploaded: (url) => customIconUrl.value = url,
                useCustomImage: useCustomImage.value,
                onUseCustomImageChanged: (value) => useCustomImage.value = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedSkill = SkillEntity(
                name: nameController.text,
                icon: useCustomImage.value ? null : IconMapper.fromString(selectedIcon.value),
                customIconUrl: useCustomImage.value ? customIconUrl.value : null,
                useCustomImage: useCustomImage.value,
              );
              final newItems = List<SkillEntity>.from(widget.skillEntities);
              newItems[index] = updatedSkill;
              widget.onChanged(newItems);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Save'),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

// ============ LIST EDITOR (for highlights, skills, etc.) ============

class ListEditorField extends StatefulWidget {
  final String label;
  final List<String> items;
  final ValueChanged<List<String>> onChanged;

  const ListEditorField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  @override
  State<ListEditorField> createState() => _ListEditorFieldState();
}

class _ListEditorFieldState extends State<ListEditorField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        ...widget.items.asMap().entries.map((entry) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: Colors.white70),
                    onPressed: () {
                      final newItems = List<String>.from(widget.items)..removeAt(entry.key);
                      widget.onChanged(newItems);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            )),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Add item...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  final newItems = List<String>.from(widget.items)..add(_controller.text);
                  widget.onChanged(newItems);
                  _controller.clear();
                }
              },
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ============ CATEGORY MANAGEMENT WIDGETS ============

// Profile Management
class ProfileManagement extends StatefulWidget {
  final AdminDashboardController controller;

  const ProfileManagement({super.key, required this.controller});

  @override
  State<ProfileManagement> createState() => _ProfileManagementState();
}

class _ProfileManagementState extends State<ProfileManagement> {
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _experienceController = TextEditingController();
  final _summaryController = TextEditingController();
  final _workPreferencesController = TextEditingController();
  final _locationController = TextEditingController();
  final _languagesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    final profile = widget.controller.profile.value;
    if (profile != null) {
      _nameController.text = profile.name;
      _titleController.text = profile.title;
      _experienceController.text = profile.experience;
      _summaryController.text = profile.summary;
      _workPreferencesController.text = profile.workPreferences;
      _locationController.text = profile.location;
      _languagesController.text = profile.languages;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 500;
              
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: AppColors.primary, size: 24),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Profile Management',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() => ElevatedButton.icon(
                            onPressed: widget.controller.isLoading.value ? null : _saveProfile,
                            icon: const Icon(Icons.save),
                            label: const Text('Save Profile'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                          )),
                    ),
                  ],
                );
              }
              
              return Row(
                children: [
                  const Icon(Icons.person, color: AppColors.primary, size: 28),
                  const SizedBox(width: 12),
                  const Flexible(
                    child: Text(
                      'Profile Management',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Obx(() => ElevatedButton.icon(
                        onPressed: widget.controller.isLoading.value ? null : _saveProfile,
                        icon: const Icon(Icons.save),
                        label: const Text('Save Profile'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      )),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Obx(() {
            final profile = widget.controller.profile.value;
            if (profile != null && _nameController.text.isEmpty) {
              _loadProfile();
            }
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  AdminTextField(label: 'Name', controller: _nameController),
                  AdminTextField(label: 'Title', controller: _titleController),
                  AdminTextField(label: 'Experience', controller: _experienceController),
                  AdminTextField(label: 'Summary', controller: _summaryController, maxLines: 4),
                  AdminTextField(label: 'Work Preferences', controller: _workPreferencesController, maxLines: 2),
                  AdminTextField(label: 'Location', controller: _locationController),
                  AdminTextField(label: 'Languages', controller: _languagesController),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _saveProfile() {
    final profile = ProfileEntity(
      name: _nameController.text,
      title: _titleController.text,
      experience: _experienceController.text,
      summary: _summaryController.text,
      workPreferences: _workPreferencesController.text,
      location: _locationController.text,
      languages: _languagesController.text,
    );
    widget.controller.updateProfile(profile);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _experienceController.dispose();
    _summaryController.dispose();
    _workPreferencesController.dispose();
    _locationController.dispose();
    _languagesController.dispose();
    super.dispose();
  }
}

// Services Management
class ServicesManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const ServicesManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Services',
      icon: Icons.design_services,
      onAdd: () => _showServiceDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.services.length,
            itemBuilder: (context, index) {
              final service = controller.services[index];
              return AdminItemCard(
                title: service.title,
                subtitle: service.description,
                icon: service.icon,
                color: service.color,
                customIconUrl: service.customIconUrl,
                useCustomImage: service.useCustomImage,
                onEdit: () => _showServiceDialog(context, service: service),
                onDelete: () => controller.deleteService(service.id),
              );
            },
          )),
    );
  }

  void _showServiceDialog(BuildContext context, {ServiceEntity? service}) {
    final titleController = TextEditingController(text: service?.title ?? '');
    final descController = TextEditingController(text: service?.description ?? '');
    
    // GetX reactive state
    final selectedIcon = (service != null ? IconMapper.iconToString(service.icon) : 'code_rounded').obs;
    final selectedColor = (service != null ? ColorMapper.colorToString(service.color) : 'primary').obs;
    final customIconUrl = Rxn<String>(service?.customIconUrl);
    final useCustomImage = (service?.useCustomImage ?? false).obs;

    Get.dialog(
      Obx(() => AdminFormDialog(
        title: service == null ? 'Add Service' : 'Edit Service',
        onSave: () {
          final newService = ServiceEntity(
            id: service?.id ?? controller.generateId(),
            title: titleController.text,
            description: descController.text,
            icon: IconMapper.fromString(selectedIcon.value),
            color: ColorMapper.fromString(selectedColor.value),
            customIconUrl: useCustomImage.value ? customIconUrl.value : null,
            useCustomImage: useCustomImage.value,
          );
          if (service == null) {
            controller.addService(newService);
          } else {
            controller.updateService(newService);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Title', controller: titleController),
          AdminTextField(label: 'Description', controller: descController, maxLines: 3),
          IconPickerField(
            label: 'Icon / Image',
            selectedIcon: selectedIcon.value,
            onChanged: (value) => selectedIcon.value = value,
            customIconUrl: customIconUrl.value,
            onCustomIconUploaded: (url) => customIconUrl.value = url,
            useCustomImage: useCustomImage.value,
            onUseCustomImageChanged: (value) => useCustomImage.value = value,
          ),
          ColorPickerField(
            label: 'Color',
            selectedColor: selectedColor.value,
            onChanged: (value) => selectedColor.value = value,
          ),
        ],
      )),
    );
  }
}

// Portfolio Management with Drag-and-Drop Reordering
class PortfolioManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const PortfolioManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Portfolio',
      icon: Icons.work,
      onAdd: () => _showPortfolioDialog(context),
      child: Obx(() {
        // Sort portfolio items by order
        final sortedItems = List<PortfolioEntity>.from(controller.portfolioItems)
          ..sort((a, b) => a.order.compareTo(b.order));
        
        return ReorderableListView.builder(
          itemCount: sortedItems.length,
          buildDefaultDragHandles: false,
          onReorder: (oldIndex, newIndex) => _onReorder(sortedItems, oldIndex, newIndex),
          proxyDecorator: (child, index, animation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                final double elevation = lerpDouble(0, 6, Curves.easeInOut.transform(animation.value))!;
                final double scale = lerpDouble(1.0, 1.02, Curves.easeInOut.transform(animation.value))!;
                return Transform.scale(
                  scale: scale,
                  child: Material(
                    elevation: elevation,
                    color: Colors.transparent,
                    shadowColor: AppColors.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
          itemBuilder: (context, index) {
            final item = sortedItems[index];
            return ReorderableDelayedDragStartListener(
              key: ValueKey(item.id),
              index: index,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AdminItemCard(
                  title: item.title,
                  subtitle: item.description,
                  icon: item.icon,
                  color: item.color,
                  customIconUrl: item.customIconUrl,
                  useCustomImage: item.useCustomImage,
                  onEdit: () => _showPortfolioDialog(context, item: item),
                  onDelete: () => controller.deletePortfolioItem(item.id),
                  extraInfo: [
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      children: item.tags.take(3).map((tag) => Chip(
                            label: Text(tag, style: const TextStyle(fontSize: 10, color: Colors.white)),
                            backgroundColor: item.color.withOpacity(0.3),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          )).toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _onReorder(List<PortfolioEntity> sortedItems, int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    
    // Create new list with updated orders
    final reorderedItems = List<PortfolioEntity>.from(sortedItems);
    final movedItem = reorderedItems.removeAt(oldIndex);
    reorderedItems.insert(newIndex, movedItem);
    
    // Update orders in database
    for (int i = 0; i < reorderedItems.length; i++) {
      final item = reorderedItems[i];
      if (item.order != i) {
        final updatedItem = item.copyWith(order: i);
        controller.updatePortfolioItem(updatedItem);
      }
    }
  }

  void _showPortfolioDialog(BuildContext context, {PortfolioEntity? item}) {
    final titleController = TextEditingController(text: item?.title ?? '');
    final categoryController = TextEditingController(text: item?.category ?? '');
    final descController = TextEditingController(text: item?.description ?? '');
    final urlController = TextEditingController(text: item?.projectUrl ?? '');
    final orderController = TextEditingController(text: item?.order.toString() ?? '0');
    
    // GetX reactive state
    final selectedIcon = (item != null ? IconMapper.iconToString(item.icon) : 'folder').obs;
    final selectedColor = (item != null ? ColorMapper.colorToString(item.color) : 'primary').obs;
    final tags = RxList<String>(List<String>.from(item?.tags ?? []));
    final customIconUrl = Rxn<String>(item?.customIconUrl);
    final useCustomImage = (item?.useCustomImage ?? false).obs;

    Get.dialog(
      Obx(() => AdminFormDialog(
        title: item == null ? 'Add Portfolio Item' : 'Edit Portfolio Item',
        onSave: () {
          final newItem = PortfolioEntity(
            id: item?.id ?? controller.generateId(),
            title: titleController.text,
            category: categoryController.text,
            description: descController.text,
            icon: IconMapper.fromString(selectedIcon.value),
            color: ColorMapper.fromString(selectedColor.value),
            tags: tags.toList(),
            projectUrl: urlController.text.isEmpty ? null : urlController.text,
            customIconUrl: useCustomImage.value ? customIconUrl.value : null,
            useCustomImage: useCustomImage.value,
            order: int.tryParse(orderController.text) ?? 0,
          );
          if (item == null) {
            controller.addPortfolioItem(newItem);
          } else {
            controller.updatePortfolioItem(newItem);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Title', controller: titleController),
          AdminTextField(label: 'Category', controller: categoryController),
          AdminTextField(label: 'Description', controller: descController, maxLines: 3),
          AdminTextField(label: 'Project URL (optional)', controller: urlController),
          AdminTextField(label: 'Display Order', controller: orderController, keyboardType: TextInputType.number, hint: 'Lower number = higher priority'),
          IconPickerField(
            label: 'Icon / Image',
            selectedIcon: selectedIcon.value,
            onChanged: (value) => selectedIcon.value = value,
            customIconUrl: customIconUrl.value,
            onCustomIconUploaded: (url) => customIconUrl.value = url,
            useCustomImage: useCustomImage.value,
            onUseCustomImageChanged: (value) => useCustomImage.value = value,
          ),
          ColorPickerField(
            label: 'Color',
            selectedColor: selectedColor.value,
            onChanged: (value) => selectedColor.value = value,
          ),
          TagsEditorField(
            label: 'Tags',
            tags: tags.toList(),
            onChanged: (value) => tags.value = value,
          ),
        ],
      )),
    );
  }
}

// Experience Management
class ExperienceManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const ExperienceManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Experience',
      icon: Icons.business,
      onAdd: () => _showExperienceDialog(context),
      child: Obx(() {
        final sortedExperiences = List<ExperienceEntity>.from(controller.experiences)
          ..sort((a, b) => a.order.compareTo(b.order));
        return ListView.builder(
          itemCount: sortedExperiences.length,
          itemBuilder: (context, index) {
            final exp = sortedExperiences[index];
            return AdminItemCard(
              title: exp.title,
              subtitle: '${exp.company} • ${exp.duration}',
              icon: exp.icon ?? Icons.work_rounded,
              color: exp.color,
              customIconUrl: exp.customIconUrl,
              useCustomImage: exp.useCustomImage,
              onEdit: () => _showExperienceDialog(context, experience: exp),
              onDelete: () => controller.deleteExperience(exp.id),
            );
          },
        );
      }),
    );
  }

  void _showExperienceDialog(BuildContext context, {ExperienceEntity? experience}) {
    final titleController = TextEditingController(text: experience?.title ?? '');
    final companyController = TextEditingController(text: experience?.company ?? '');
    final locationController = TextEditingController(text: experience?.location ?? '');
    final durationController = TextEditingController(text: experience?.duration ?? '');
    final orderController = TextEditingController(text: experience?.order.toString() ?? '0');
    final highlights = List<String>.from(experience?.highlights ?? []).obs;
    final selectedIcon = (experience?.icon != null ? IconMapper.iconToString(experience!.icon!) : 'work_rounded').obs;
    final selectedColor = (experience?.color != null ? ColorMapper.colorToString(experience!.color!) : 'blue').obs;
    final customIconUrl = Rxn<String>(experience?.customIconUrl);
    final useCustomImage = (experience?.useCustomImage ?? false).obs;

    Get.dialog(
      Obx(() => AdminFormDialog(
        title: experience == null ? 'Add Experience' : 'Edit Experience',
        onSave: () {
          final newExp = ExperienceEntity(
            id: experience?.id ?? controller.generateId(),
            title: titleController.text,
            company: companyController.text,
            location: locationController.text,
            duration: durationController.text,
            highlights: highlights,
            icon: IconMapper.fromString(selectedIcon.value),
            color: ColorMapper.fromString(selectedColor.value),
            customIconUrl: useCustomImage.value ? customIconUrl.value : null,
            useCustomImage: useCustomImage.value,
            order: int.tryParse(orderController.text) ?? 0,
          );
          if (experience == null) {
            controller.addExperience(newExp);
          } else {
            controller.updateExperience(newExp);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Job Title', controller: titleController),
          AdminTextField(label: 'Company', controller: companyController),
          AdminTextField(label: 'Location', controller: locationController),
          AdminTextField(label: 'Duration', controller: durationController),
          AdminTextField(label: 'Display Order', controller: orderController, keyboardType: TextInputType.number),
          IconPickerField(
            label: 'Icon / Image',
            selectedIcon: selectedIcon.value,
            onChanged: (value) => selectedIcon.value = value,
            customIconUrl: customIconUrl.value,
            onCustomIconUploaded: (url) => customIconUrl.value = url,
            useCustomImage: useCustomImage.value,
            onUseCustomImageChanged: (value) => useCustomImage.value = value,
          ),
          ColorPickerField(
            label: 'Color',
            selectedColor: selectedColor.value,
            onChanged: (value) => selectedColor.value = value,
          ),
          ListEditorField(
            label: 'Highlights',
            items: highlights,
            onChanged: (value) => highlights.value = value,
          ),
        ],
      )),
    );
  }
}

// Projects Management with Drag-and-Drop Reordering
class ProjectsManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const ProjectsManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Projects',
      icon: Icons.folder,
      onAdd: () => _showProjectDialog(context),
      child: Obx(() {
        // Sort projects by order
        final sortedProjects = List<ProjectDetailEntity>.from(controller.projectDetails)
          ..sort((a, b) => a.order.compareTo(b.order));
        
        return ReorderableListView.builder(
          itemCount: sortedProjects.length,
          buildDefaultDragHandles: false,
          onReorder: (oldIndex, newIndex) => _onReorder(sortedProjects, oldIndex, newIndex),
          proxyDecorator: (child, index, animation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                final double elevation = lerpDouble(0, 6, Curves.easeInOut.transform(animation.value))!;
                final double scale = lerpDouble(1.0, 1.02, Curves.easeInOut.transform(animation.value))!;
                return Transform.scale(
                  scale: scale,
                  child: Material(
                    elevation: elevation,
                    color: Colors.transparent,
                    shadowColor: AppColors.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
          itemBuilder: (context, index) {
            final project = sortedProjects[index];
            return ReorderableDelayedDragStartListener(
              key: ValueKey(project.id),
              index: index,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AdminItemCard(
                  title: project.title,
                  subtitle: '${project.category} • ${project.year}',
                  icon: project.icon,
                  color: project.color,
                  customIconUrl: project.customIconUrl,
                  useCustomImage: project.useCustomImage,
                  onEdit: () => _showProjectDialog(context, project: project),
                  onDelete: () => controller.deleteProjectDetail(project.id),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _onReorder(List<ProjectDetailEntity> sortedProjects, int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    
    // Create new list with updated orders
    final reorderedItems = List<ProjectDetailEntity>.from(sortedProjects);
    final movedItem = reorderedItems.removeAt(oldIndex);
    reorderedItems.insert(newIndex, movedItem);
    
    // Update orders in database
    for (int i = 0; i < reorderedItems.length; i++) {
      final item = reorderedItems[i];
      if (item.order != i) {
        final updatedItem = item.copyWith(order: i);
        controller.updateProjectDetail(updatedItem);
      }
    }
  }

  void _showProjectDialog(BuildContext context, {ProjectDetailEntity? project}) {
    final titleController = TextEditingController(text: project?.title ?? '');
    final categoryController = TextEditingController(text: project?.category ?? '');
    final yearController = TextEditingController(text: project?.year ?? '');
    final descController = TextEditingController(text: project?.description ?? '');
    final urlController = TextEditingController(text: project?.url ?? '');
    final selectedIcon = (project != null ? IconMapper.iconToString(project.icon) : 'folder').obs;
    final selectedColor = (project != null ? ColorMapper.colorToString(project.color) : 'primary').obs;
    final highlights = List<String>.from(project?.highlights ?? []).obs;
    final tags = List<String>.from(project?.tags ?? []).obs;
    final customIconUrl = Rxn<String>(project?.customIconUrl);
    final useCustomImage = (project?.useCustomImage ?? false).obs;

    Get.dialog(
      Obx(() => AdminFormDialog(
        title: project == null ? 'Add Project' : 'Edit Project',
        onSave: () {
          final newProject = ProjectDetailEntity(
            id: project?.id ?? controller.generateId(),
            title: titleController.text,
            category: categoryController.text,
            year: yearController.text,
            description: descController.text,
            icon: IconMapper.fromString(selectedIcon.value),
            color: ColorMapper.fromString(selectedColor.value),
            highlights: highlights,
            tags: tags,
            url: urlController.text.isEmpty ? null : urlController.text,
            customIconUrl: useCustomImage.value ? customIconUrl.value : null,
            useCustomImage: useCustomImage.value,
          );
          if (project == null) {
            controller.addProjectDetail(newProject);
          } else {
            controller.updateProjectDetail(newProject);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Title', controller: titleController),
          AdminTextField(label: 'Category', controller: categoryController),
          AdminTextField(label: 'Year', controller: yearController),
          AdminTextField(label: 'Description', controller: descController, maxLines: 3),
          AdminTextField(label: 'URL (optional)', controller: urlController),
          IconPickerField(
            label: 'Icon / Image',
            selectedIcon: selectedIcon.value,
            onChanged: (value) => selectedIcon.value = value,
            customIconUrl: customIconUrl.value,
            onCustomIconUploaded: (url) => customIconUrl.value = url,
            useCustomImage: useCustomImage.value,
            onUseCustomImageChanged: (value) => useCustomImage.value = value,
          ),
          ColorPickerField(
            label: 'Color',
            selectedColor: selectedColor.value,
            onChanged: (value) => selectedColor.value = value,
          ),
          ListEditorField(
            label: 'Highlights',
            items: highlights,
            onChanged: (value) => highlights.value = value,
          ),
          TagsEditorField(
            label: 'Tags',
            tags: tags,
            onChanged: (value) => tags.value = value,
          ),
        ],
      )),
    );
  }
}

// Education Management
class EducationManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const EducationManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Education',
      icon: Icons.school,
      onAdd: () => _showEducationDialog(context),
      child: Obx(() {
        final sortedEducation = List<EducationEntity>.from(controller.education)
          ..sort((a, b) => a.order.compareTo(b.order));
        return ListView.builder(
          itemCount: sortedEducation.length,
          itemBuilder: (context, index) {
            final edu = sortedEducation[index];
            return AdminItemCard(
              title: edu.degree,
              subtitle: '${edu.institution} • ${edu.duration}',
              icon: edu.icon ?? Icons.school_rounded,
              color: edu.color,
              customIconUrl: edu.customIconUrl,
              useCustomImage: edu.useCustomImage,
              onEdit: () => _showEducationDialog(context, education: edu),
              onDelete: () => controller.deleteEducation(edu.id),
            );
          },
        );
      }),
    );
  }

  void _showEducationDialog(BuildContext context, {EducationEntity? education}) {
    final degreeController = TextEditingController(text: education?.degree ?? '');
    final institutionController = TextEditingController(text: education?.institution ?? '');
    final durationController = TextEditingController(text: education?.duration ?? '');
    final cgpaController = TextEditingController(text: education?.cgpa ?? '');
    final specializationController = TextEditingController(text: education?.specialization ?? '');
    final projectController = TextEditingController(text: education?.project ?? '');
    final orderController = TextEditingController(text: education?.order.toString() ?? '0');
    final selectedIcon = (education?.icon != null ? IconMapper.iconToString(education!.icon!) : 'school_rounded').obs;
    final selectedColor = (education?.color != null ? ColorMapper.colorToString(education!.color!) : 'blue').obs;
    final customIconUrl = Rxn<String>(education?.customIconUrl);
    final useCustomImage = (education?.useCustomImage ?? false).obs;

    Get.dialog(
      Obx(() => AdminFormDialog(
        title: education == null ? 'Add Education' : 'Edit Education',
        onSave: () {
          final newEdu = EducationEntity(
            id: education?.id ?? controller.generateId(),
            degree: degreeController.text,
            institution: institutionController.text,
            duration: durationController.text,
            cgpa: cgpaController.text.isNotEmpty ? cgpaController.text : null,
            specialization: specializationController.text.isNotEmpty ? specializationController.text : null,
            project: projectController.text.isNotEmpty ? projectController.text : null,
            icon: IconMapper.fromString(selectedIcon.value),
            color: ColorMapper.fromString(selectedColor.value),
            customIconUrl: useCustomImage.value ? customIconUrl.value : null,
            useCustomImage: useCustomImage.value,
            order: int.tryParse(orderController.text) ?? 0,
          );
          if (education == null) {
            controller.addEducation(newEdu);
          } else {
            controller.updateEducation(newEdu);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Degree', controller: degreeController),
          AdminTextField(label: 'Institution', controller: institutionController),
          AdminTextField(label: 'Duration', controller: durationController),
          AdminTextField(label: 'CGPA (optional)', controller: cgpaController),
          AdminTextField(label: 'Specialization (optional)', controller: specializationController),
          AdminTextField(label: 'Project (optional)', controller: projectController),
          AdminTextField(label: 'Display Order', controller: orderController, keyboardType: TextInputType.number),
          IconPickerField(
            label: 'Icon / Image',
            selectedIcon: selectedIcon.value,
            onChanged: (value) => selectedIcon.value = value,
            customIconUrl: customIconUrl.value,
            onCustomIconUploaded: (url) => customIconUrl.value = url,
            useCustomImage: useCustomImage.value,
            onUseCustomImageChanged: (value) => useCustomImage.value = value,
          ),
          ColorPickerField(
            label: 'Color',
            selectedColor: selectedColor.value,
            onChanged: (value) => selectedColor.value = value,
          ),
        ],
      )),
    );
  }
}

// Certifications Management
class CertificationsManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const CertificationsManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Certifications',
      icon: Icons.workspace_premium,
      onAdd: () => _showCertificationDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.certifications.length,
            itemBuilder: (context, index) {
              final cert = controller.certifications[index];
              return AdminItemCard(
                title: cert.title,
                subtitle: '${cert.issuer} • ${cert.year}',
                icon: Icons.workspace_premium,
                onEdit: () => _showCertificationDialog(context, certification: cert),
                onDelete: () => controller.deleteCertification(cert.id),
              );
            },
          )),
    );
  }

  void _showCertificationDialog(BuildContext context, {CertificationEntity? certification}) {
    final titleController = TextEditingController(text: certification?.title ?? '');
    final issuerController = TextEditingController(text: certification?.issuer ?? '');
    final yearController = TextEditingController(text: certification?.year ?? '');

    Get.dialog(
      AdminFormDialog(
        title: certification == null ? 'Add Certification' : 'Edit Certification',
        onSave: () {
          final newCert = CertificationEntity(
            id: certification?.id ?? controller.generateId(),
            title: titleController.text,
            issuer: issuerController.text,
            year: yearController.text,
          );
          if (certification == null) {
            controller.addCertification(newCert);
          } else {
            controller.updateCertification(newCert);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Title', controller: titleController),
          AdminTextField(label: 'Issuer', controller: issuerController),
          AdminTextField(label: 'Year', controller: yearController),
        ],
      ),
    );
  }
}

// Expertise Management
class ExpertiseManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const ExpertiseManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Skills & Expertise',
      icon: Icons.code,
      onAdd: () => _showExpertiseDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.expertise.length,
            itemBuilder: (context, index) {
              final exp = controller.expertise[index];
              return AdminItemCard(
                title: exp.title,
                subtitle: '${exp.skills.length} skills',
                icon: exp.icon,
                color: exp.color,
                customIconUrl: exp.customIconUrl,
                useCustomImage: exp.useCustomImage,
                onEdit: () => _showExpertiseDialog(context, expertise: exp),
                onDelete: () => controller.deleteExpertise(exp.id),
              );
            },
          )),
    );
  }

  void _showExpertiseDialog(BuildContext context, {ExpertiseEntity? expertise}) {
    final titleController = TextEditingController(text: expertise?.title ?? '');
    final selectedIcon = (expertise != null ? IconMapper.iconToString(expertise.icon) : 'code_rounded').obs;
    final selectedColor = (expertise != null ? ColorMapper.colorToString(expertise.color) : 'primary').obs;
    final skillEntities = RxList<SkillEntity>(List<SkillEntity>.from(expertise?.skillEntities ?? []));
    final customIconUrl = Rxn<String>(expertise?.customIconUrl);
    final useCustomImage = (expertise?.useCustomImage ?? false).obs;

    Get.dialog(
      Obx(() => AdminFormDialog(
        title: expertise == null ? 'Add Expertise' : 'Edit Expertise',
        onSave: () {
          // Sync skills list with skillEntities names
          final syncedSkills = skillEntities.map((s) => s.name).toList();
          
          final newExp = ExpertiseEntity(
            id: expertise?.id ?? controller.generateId(),
            title: titleController.text,
            icon: IconMapper.fromString(selectedIcon.value),
            color: ColorMapper.fromString(selectedColor.value),
            skills: syncedSkills,
            skillEntities: skillEntities.toList(),
            customIconUrl: useCustomImage.value ? customIconUrl.value : null,
            useCustomImage: useCustomImage.value,
          );
          if (expertise == null) {
            controller.addExpertise(newExp);
          } else {
            controller.updateExpertise(newExp);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Title', controller: titleController),
          IconPickerField(
            label: 'Category Icon / Image',
            selectedIcon: selectedIcon.value,
            onChanged: (value) => selectedIcon.value = value,
            customIconUrl: customIconUrl.value,
            onCustomIconUploaded: (url) => customIconUrl.value = url,
            useCustomImage: useCustomImage.value,
            onUseCustomImageChanged: (value) => useCustomImage.value = value,
          ),
          ColorPickerField(
            label: 'Color',
            selectedColor: selectedColor.value,
            onChanged: (value) => selectedColor.value = value,
          ),
          SkillsEditorField(
            label: 'Skills (with optional icons)',
            skillEntities: skillEntities.toList(),
            onChanged: (value) => skillEntities.value = value,
          ),
        ],
      )),
    );
  }
}

// Achievements Management
class AchievementsManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const AchievementsManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Achievements',
      icon: Icons.emoji_events,
      onAdd: () => _showAchievementDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.achievements.length,
            itemBuilder: (context, index) {
              final ach = controller.achievements[index];
              return AdminItemCard(
                title: ach.text,
                icon: ach.icon,
                customIconUrl: ach.customIconUrl,
                useCustomImage: ach.useCustomImage,
                onEdit: () => _showAchievementDialog(context, achievement: ach),
                onDelete: () => controller.deleteAchievement(ach.id),
              );
            },
          )),
    );
  }

  void _showAchievementDialog(BuildContext context, {AchievementEntity? achievement}) {
    final textController = TextEditingController(text: achievement?.text ?? '');
    final selectedIcon = (achievement != null ? IconMapper.iconToString(achievement.icon) : 'star_rounded').obs;
    final customIconUrl = Rxn<String>(achievement?.customIconUrl);
    final useCustomImage = (achievement?.useCustomImage ?? false).obs;

    Get.dialog(
      Obx(() => AdminFormDialog(
        title: achievement == null ? 'Add Achievement' : 'Edit Achievement',
        onSave: () {
          final newAch = AchievementEntity(
            id: achievement?.id ?? controller.generateId(),
            icon: IconMapper.fromString(selectedIcon.value),
            text: textController.text,
            customIconUrl: useCustomImage.value ? customIconUrl.value : null,
            useCustomImage: useCustomImage.value,
          );
          if (achievement == null) {
            controller.addAchievement(newAch);
          } else {
            controller.updateAchievement(newAch);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Achievement Text', controller: textController, maxLines: 2),
          IconPickerField(
            label: 'Icon / Image',
            selectedIcon: selectedIcon.value,
            onChanged: (value) => selectedIcon.value = value,
            customIconUrl: customIconUrl.value,
            onCustomIconUploaded: (url) => customIconUrl.value = url,
            useCustomImage: useCustomImage.value,
            onUseCustomImageChanged: (value) => useCustomImage.value = value,
          ),
        ],
      )),
    );
  }
}

// Contact Management
class ContactManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const ContactManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Contact Info',
      icon: Icons.contact_mail,
      onAdd: () => _showContactDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.contactInfo.length,
            itemBuilder: (context, index) {
              final info = controller.contactInfo[index];
              return AdminItemCard(
                title: info.title,
                subtitle: info.value,
                icon: info.icon,
                color: info.color,
                customIconUrl: info.customIconUrl,
                useCustomImage: info.useCustomImage,
                onEdit: () => _showContactDialog(context, contact: info),
                onDelete: () => controller.deleteContactInfo(info.id),
              );
            },
          )),
    );
  }

  void _showContactDialog(BuildContext context, {ContactInfoEntity? contact}) {
    final titleController = TextEditingController(text: contact?.title ?? '');
    final valueController = TextEditingController(text: contact?.value ?? '');
    final actionTypeController = TextEditingController(text: contact?.actionType ?? '');
    final selectedIcon = (contact != null ? IconMapper.iconToString(contact.icon) : 'email_rounded').obs;
    final selectedColor = (contact != null ? ColorMapper.colorToString(contact.color) : 'primary').obs;
    final customIconUrl = Rxn<String>(contact?.customIconUrl);
    final useCustomImage = (contact?.useCustomImage ?? false).obs;

    Get.dialog(
      Obx(() => AdminFormDialog(
        title: contact == null ? 'Add Contact Info' : 'Edit Contact Info',
        onSave: () {
          final newContact = ContactInfoEntity(
            id: contact?.id ?? controller.generateId(),
            title: titleController.text,
            value: valueController.text,
            icon: IconMapper.fromString(selectedIcon.value),
            color: ColorMapper.fromString(selectedColor.value),
            actionType: actionTypeController.text,
            customIconUrl: useCustomImage.value ? customIconUrl.value : null,
            useCustomImage: useCustomImage.value,
          );
          if (contact == null) {
            controller.addContactInfo(newContact);
          } else {
            controller.updateContactInfo(newContact);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Title', controller: titleController, hint: 'e.g., Email, Phone'),
          AdminTextField(label: 'Value', controller: valueController, hint: 'e.g., email@example.com'),
          AdminTextField(label: 'Action Type', controller: actionTypeController, hint: 'e.g., email, phone, whatsapp'),
          IconPickerField(
            label: 'Icon / Image',
            selectedIcon: selectedIcon.value,
            onChanged: (value) => selectedIcon.value = value,
            customIconUrl: customIconUrl.value,
            onCustomIconUploaded: (url) => customIconUrl.value = url,
            useCustomImage: useCustomImage.value,
            onUseCustomImageChanged: (value) => useCustomImage.value = value,
          ),
          ColorPickerField(
            label: 'Color',
            selectedColor: selectedColor.value,
            onChanged: (value) => selectedColor.value = value,
          ),
        ],
      )),
    );
  }
}

// Social Links Management
class SocialLinksManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const SocialLinksManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Social Links',
      icon: Icons.share,
      onAdd: () => _showSocialLinkDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.socialLinks.length,
            itemBuilder: (context, index) {
              final link = controller.socialLinks[index];
              return AdminItemCard(
                title: link.name,
                subtitle: link.url,
                icon: link.icon,
                customIconUrl: link.customIconUrl,
                useCustomImage: link.useCustomImage,
                onEdit: () => _showSocialLinkDialog(context, link: link),
                onDelete: () => controller.deleteSocialLink(link.id),
              );
            },
          )),
    );
  }

  void _showSocialLinkDialog(BuildContext context, {SocialLinkEntity? link}) {
    final nameController = TextEditingController(text: link?.name ?? '');
    final urlController = TextEditingController(text: link?.url ?? '');
    final selectedIcon = (link != null ? IconMapper.iconToString(link.icon) : 'link').obs;
    final customIconUrl = Rxn<String>(link?.customIconUrl);
    final useCustomImage = (link?.useCustomImage ?? false).obs;

    Get.dialog(
      Obx(() => AdminFormDialog(
        title: link == null ? 'Add Social Link' : 'Edit Social Link',
        onSave: () {
          final newLink = SocialLinkEntity(
            id: link?.id ?? controller.generateId(),
            name: nameController.text,
            url: urlController.text,
            icon: IconMapper.fromString(selectedIcon.value),
            customIconUrl: useCustomImage.value ? customIconUrl.value : null,
            useCustomImage: useCustomImage.value,
          );
          if (link == null) {
            controller.addSocialLink(newLink);
          } else {
            controller.updateSocialLink(newLink);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Name', controller: nameController, hint: 'e.g., GitHub, LinkedIn'),
          AdminTextField(label: 'URL', controller: urlController, hint: 'https://...'),
          IconPickerField(
            label: 'Icon / Image',
            selectedIcon: selectedIcon.value,
            onChanged: (value) => selectedIcon.value = value,
            customIconUrl: customIconUrl.value,
            onCustomIconUploaded: (url) => customIconUrl.value = url,
            useCustomImage: useCustomImage.value,
            onUseCustomImageChanged: (value) => useCustomImage.value = value,
          ),
        ],
      )),
    );
  }
}

// Stats Management
class StatsManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const StatsManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Statistics',
      icon: Icons.analytics,
      onAdd: () => _showStatDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.stats.length,
            itemBuilder: (context, index) {
              final stat = controller.stats[index];
              return AdminItemCard(
                title: stat.value,
                subtitle: stat.label,
                icon: Icons.analytics,
                onEdit: () => _showStatDialog(context, stat: stat),
                onDelete: () => controller.deleteStat(stat.id),
              );
            },
          )),
    );
  }

  void _showStatDialog(BuildContext context, {StatEntity? stat}) {
    final valueController = TextEditingController(text: stat?.value ?? '');
    final labelController = TextEditingController(text: stat?.label ?? '');

    Get.dialog(
      AdminFormDialog(
        title: stat == null ? 'Add Stat' : 'Edit Stat',
        onSave: () {
          final newStat = StatEntity(
            id: stat?.id ?? controller.generateId(),
            value: valueController.text,
            label: labelController.text,
          );
          if (stat == null) {
            controller.addStat(newStat);
          } else {
            controller.updateStat(newStat);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Value', controller: valueController, hint: 'e.g., 50+'),
          AdminTextField(label: 'Label', controller: labelController, hint: 'e.g., Projects Completed'),
        ],
      ),
    );
  }
}

// ============ HERO SECTION MANAGEMENT ============

class HeroSectionManagement extends StatefulWidget {
  final AdminDashboardController controller;

  const HeroSectionManagement({super.key, required this.controller});

  @override
  State<HeroSectionManagement> createState() => _HeroSectionManagementState();
}

class _HeroSectionManagementState extends State<HeroSectionManagement> {
  final _greetingController = TextEditingController();
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ctaButtonTextController = TextEditingController();
  final _ctaButtonLinkController = TextEditingController();
  final _videoUrlController = TextEditingController();
  
  String? _profileImageUrl;
  String? _backgroundImageUrl;
  bool _isLoading = false;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _loadHeroSection();
  }

  void _loadHeroSection() {
    final hero = widget.controller.heroSection.value;
    if (hero != null) {
      _greetingController.text = hero.greeting;
      _nameController.text = hero.name;
      _titleController.text = hero.title;
      _subtitleController.text = hero.subtitle;
      _descriptionController.text = hero.description;
      _ctaButtonTextController.text = hero.ctaButtonText;
      _ctaButtonLinkController.text = hero.ctaButtonLink;
      _videoUrlController.text = hero.videoUrl ?? '';
      _profileImageUrl = hero.profileImageUrl;
      _backgroundImageUrl = hero.backgroundImageUrl;
    }
  }

  Future<void> _pickAndUploadImage(String type) async {
    try {
      setState(() => _isUploading = true);
      
      final Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();
      if (imageBytes == null) {
        setState(() => _isUploading = false);
        return;
      }

      final storage = Get.find<StorageDataSource>();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_$type.png';
      
      final downloadUrl = await storage.uploadImage(
        imageBytes: imageBytes,
        path: 'hero',
        fileName: fileName,
      );

      setState(() {
        if (type == 'profile') {
          _profileImageUrl = downloadUrl;
        } else {
          _backgroundImageUrl = downloadUrl;
        }
        _isUploading = false;
      });

      Get.snackbar('Success', 'Image uploaded successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      setState(() => _isUploading = false);
      Get.snackbar('Error', 'Failed to upload image: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> _saveHeroSection() async {
    setState(() => _isLoading = true);
    
    try {
      final heroSection = HeroSectionEntity(
        id: 'main',
        greeting: _greetingController.text,
        name: _nameController.text,
        title: _titleController.text,
        subtitle: _subtitleController.text,
        description: _descriptionController.text,
        ctaButtonText: _ctaButtonTextController.text,
        ctaButtonLink: _ctaButtonLinkController.text,
        profileImageUrl: _profileImageUrl,
        backgroundImageUrl: _backgroundImageUrl,
        videoUrl: _videoUrlController.text.isNotEmpty ? _videoUrlController.text : null,
      );

      await widget.controller.updateHeroSection(heroSection);
      Get.snackbar('Success', 'Hero section updated successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update hero section: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 500;
              
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.home, color: AppColors.primary, size: 24),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Hero Section',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _saveHeroSection,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.save),
                        label: Text(_isLoading ? 'Saving...' : 'Save Changes'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                );
              }
              
              return Row(
                children: [
                  const Icon(Icons.home, color: AppColors.primary, size: 28),
                  const SizedBox(width: 12),
                  const Flexible(
                    child: Text(
                      'Hero Section (Home Screen)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _saveHeroSection,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    label: Text(_isLoading ? 'Saving...' : 'Save Changes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Obx(() {
              final hero = widget.controller.heroSection.value;
              if (hero != null && _greetingController.text.isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) => _loadHeroSection());
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text Fields Section
                    _buildSectionTitle('Text Content'),
                    const SizedBox(height: 16),
                    _buildTextField('Greeting', _greetingController, "e.g., Hello, I'm"),
                    _buildTextField('Name', _nameController, 'Your full name'),
                    _buildTextField('Title', _titleController, 'e.g., Flutter Developer'),
                    _buildTextField('Subtitle', _subtitleController, 'e.g., Mobile & Web Applications'),
                    _buildTextField('Description', _descriptionController, 'Brief description', maxLines: 3),
                    _buildTextField('CTA Button Text', _ctaButtonTextController, 'e.g., Get In Touch'),
                    _buildTextField('CTA Button Link', _ctaButtonLinkController, 'e.g., /contact'),
                    
                    const SizedBox(height: 32),
                    _buildSectionTitle('Media'),
                    const SizedBox(height: 16),
                    
                    // Profile Image
                    _buildImageUploadSection(
                      'Profile Image',
                      _profileImageUrl,
                      () => _pickAndUploadImage('profile'),
                      'Recommended: 400x400px',
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Background Image
                    _buildImageUploadSection(
                      'Background Image',
                      _backgroundImageUrl,
                      () => _pickAndUploadImage('background'),
                      'Recommended: 1920x1080px',
                    ),
                    
                    const SizedBox(height: 24),
                    _buildTextField('Video URL (Optional)', _videoUrlController, 'YouTube or video link'),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.primary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
              filled: true,
              fillColor: const Color(0xFF1E293B),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadSection(String label, String? imageUrl, VoidCallback onUpload, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Preview
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.broken_image, color: Colors.white54, size: 48),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(Icons.image, color: Colors.white30, size: 48),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: _isUploading ? null : onUpload,
                  icon: _isUploading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.cloud_upload, size: 18),
                  label: Text(_isUploading ? 'Uploading...' : 'Upload Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(hint, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _greetingController.dispose();
    _nameController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    _ctaButtonTextController.dispose();
    _ctaButtonLinkController.dispose();
    _videoUrlController.dispose();
    super.dispose();
  }
}

// ============ IMAGE UPLOAD FIELD FOR FORMS ============

class ImageUploadField extends StatefulWidget {
  final String label;
  final String? currentImageUrl;
  final String storagePath;
  final Function(String) onImageUploaded;
  final String hint;

  const ImageUploadField({
    super.key,
    required this.label,
    this.currentImageUrl,
    required this.storagePath,
    required this.onImageUploaded,
    this.hint = 'Upload an image',
  });

  @override
  State<ImageUploadField> createState() => _ImageUploadFieldState();
}

class _ImageUploadFieldState extends State<ImageUploadField> {
  bool _isUploading = false;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.currentImageUrl;
  }

  @override
  void didUpdateWidget(ImageUploadField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentImageUrl != oldWidget.currentImageUrl) {
      _imageUrl = widget.currentImageUrl;
    }
  }

  Future<void> _pickAndUpload() async {
    try {
      setState(() => _isUploading = true);
      
      final Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();
      if (imageBytes == null) {
        setState(() => _isUploading = false);
        return;
      }

      final storage = Get.find<StorageDataSource>();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      
      final downloadUrl = await storage.uploadImage(
        imageBytes: imageBytes,
        path: widget.storagePath,
        fileName: fileName,
      );

      setState(() {
        _imageUrl = downloadUrl;
        _isUploading = false;
      });

      widget.onImageUploaded(downloadUrl);
    } catch (e) {
      setState(() => _isUploading = false);
      Get.snackbar('Error', 'Failed to upload: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: _imageUrl != null && _imageUrl!.isNotEmpty
                      ? Image.network(_imageUrl!, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white30))
                      : const Icon(Icons.image, color: Colors.white30),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _isUploading ? null : _pickAndUpload,
                icon: _isUploading
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.upload, size: 16),
                label: Text(_isUploading ? 'Uploading...' : 'Upload'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ],
          ),
          if (widget.hint.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(widget.hint, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11)),
            ),
        ],
      ),
    );
  }
}

// ============ CV MANAGEMENT ============

class CvManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const CvManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsivePadding.all(context, multiplier: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description, color: AppColors.primary, size: 28),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'CV / Resume',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Obx(() => _buildCvContent(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildCvContent(BuildContext context) {
    final cv = controller.currentCv.value;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardBg.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current CV',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              if (cv != null) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.picture_as_pdf, color: AppColors.primary, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cv.filename,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Uploaded: ${_formatDate(cv.uploadedAt)}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 12,
                              ),
                            ),
                            if (cv.fileSize != null)
                              Text(
                                'Size: ${_formatFileSize(cv.fileSize!)}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _openCvUrl(cv.url),
                        icon: const Icon(Icons.open_in_new, color: AppColors.primary),
                        tooltip: 'Open CV',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.upload_file, color: Colors.white.withOpacity(0.3), size: 48),
                      const SizedBox(height: 12),
                      Text(
                        'No CV uploaded yet',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
              const Text(
                'Upload New CV',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Upload a PDF file of your CV/Resume. This will be available for download on the website.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              _CvUploadButton(
                onCvUploaded: (url, filename, fileSize) {
                  final newCv = CvEntity(
                    id: 'current',
                    url: url,
                    filename: filename,
                    uploadedAt: DateTime.now(),
                    fileSize: fileSize,
                  );
                  controller.updateCv(newCv);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  void _openCvUrl(String url) {
    launchUrlString(url);
  }
}

class _CvUploadButton extends StatefulWidget {
  final Function(String url, String filename, int fileSize) onCvUploaded;

  const _CvUploadButton({required this.onCvUploaded});

  @override
  State<_CvUploadButton> createState() => _CvUploadButtonState();
}

class _CvUploadButtonState extends State<_CvUploadButton> {
  bool _isUploading = false;
  String? _selectedFileName;

  Future<void> _pickAndUploadCv() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      
      if (file.bytes == null) {
        Get.snackbar('Error', 'Could not read file',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      if (file.extension?.toLowerCase() != 'pdf') {
        Get.snackbar('Error', 'Only PDF files are allowed',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      setState(() {
        _isUploading = true;
        _selectedFileName = file.name;
      });

      final storage = Get.find<StorageDataSource>();
      final fileName = 'Engr_Hamid_Raza_cv_${DateTime.now().millisecondsSinceEpoch}.pdf';
      
      final downloadUrl = await storage.uploadFile(
        fileBytes: file.bytes!,
        path: 'cv',
        fileName: fileName,
        contentType: 'application/pdf',
      );

      setState(() => _isUploading = false);

      widget.onCvUploaded(downloadUrl, file.name, file.size);
    } catch (e) {
      setState(() => _isUploading = false);
      Get.snackbar('Error', 'Failed to upload CV: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: _isUploading ? null : _pickAndUploadCv,
          icon: _isUploading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Icon(Icons.upload_file),
          label: Text(_isUploading ? 'Uploading...' : 'Select PDF File'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        if (_selectedFileName != null && _isUploading)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Uploading: $_selectedFileName',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
