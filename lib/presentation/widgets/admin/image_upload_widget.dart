import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/datasources/remote/storage_datasource.dart';

/// Image upload widget for Admin Panel
/// Handles image selection, preview, upload, and replacement
class ImageUploadWidget extends StatefulWidget {
  final String? currentImageUrl;
  final String storagePath;
  final String imageType;
  final Function(String) onImageUploaded;
  final double? previewWidth;
  final double? previewHeight;
  final BoxFit fit;

  const ImageUploadWidget({
    super.key,
    this.currentImageUrl,
    required this.storagePath,
    required this.imageType,
    required this.onImageUploaded,
    this.previewWidth,
    this.previewHeight,
    this.fit = BoxFit.cover,
  });

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  bool _isUploading = false;
  double _uploadProgress = 0;
  String? _previewUrl;
  Uint8List? _selectedImageBytes;

  @override
  void initState() {
    super.initState();
    _previewUrl = widget.currentImageUrl;
  }

  @override
  void didUpdateWidget(ImageUploadWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentImageUrl != oldWidget.currentImageUrl) {
      setState(() {
        _previewUrl = widget.currentImageUrl;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();
      
      if (imageBytes != null) {
        setState(() {
          _selectedImageBytes = imageBytes;
          _previewUrl = null; // Show local preview
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImageBytes == null) return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0;
    });

    try {
      final storageDataSource = Get.find<StorageDataSource>();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${widget.imageType}.png';

      final downloadUrl = await storageDataSource.uploadImage(
        imageBytes: _selectedImageBytes!,
        path: widget.storagePath,
        fileName: fileName,
        contentType: 'image/png',
      );

      // Delete old image if exists
      if (widget.currentImageUrl != null && widget.currentImageUrl!.isNotEmpty) {
        await storageDataSource.deleteImage(widget.currentImageUrl!);
      }

      setState(() {
        _previewUrl = downloadUrl;
        _selectedImageBytes = null;
        _isUploading = false;
      });

      widget.onImageUploaded(downloadUrl);

      Get.snackbar(
        'Success',
        'Image uploaded successfully',
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      debugPrint('Error uploading image: $e');
      Get.snackbar(
        'Error',
        'Failed to upload image: $e',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void _cancelSelection() {
    setState(() {
      _selectedImageBytes = null;
      _previewUrl = widget.currentImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = ImageConfig.getSize(widget.imageType);
    final previewWidth = widget.previewWidth ?? size.width.toDouble().clamp(100, 300);
    final previewHeight = widget.previewHeight ?? size.height.toDouble().clamp(100, 200);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preview area
        Container(
          width: previewWidth,
          height: previewHeight,
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _buildPreview(),
          ),
        ),
        const SizedBox(height: 12),
        
        // Action buttons
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selectedImageBytes == null) ...[
              ElevatedButton.icon(
                onPressed: _isUploading ? null : _pickImage,
                icon: const Icon(Icons.image, size: 18),
                label: Text(_previewUrl != null ? 'Change' : 'Select'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ] else ...[
              ElevatedButton.icon(
                onPressed: _isUploading ? null : _uploadImage,
                icon: _isUploading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.cloud_upload, size: 18),
                label: Text(_isUploading ? 'Uploading...' : 'Upload'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: _isUploading ? null : _cancelSelection,
                icon: const Icon(Icons.close, size: 18),
                label: const Text('Cancel'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ],
          ],
        ),
        
        // Size hint
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Recommended: ${size.width}x${size.height}px',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textMuted.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreview() {
    if (_isUploading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: _uploadProgress > 0 ? _uploadProgress : null,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              '${(_uploadProgress * 100).toInt()}%',
              style: const TextStyle(color: AppColors.textMuted),
            ),
          ],
        ),
      );
    }

    if (_selectedImageBytes != null) {
      return Image.memory(
        _selectedImageBytes!,
        fit: widget.fit,
      );
    }

    if (_previewUrl != null && _previewUrl!.isNotEmpty) {
      return Image.network(
        _previewUrl!,
        fit: widget.fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              color: AppColors.primary,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.broken_image,
              size: 48,
              color: AppColors.textMuted,
            ),
          );
        },
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate,
            size: 48,
            color: AppColors.textMuted.withOpacity(0.5),
          ),
          const SizedBox(height: 8),
          Text(
            'No image selected',
            style: TextStyle(
              color: AppColors.textMuted.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact image upload field for forms
class ImageUploadField extends StatelessWidget {
  final String label;
  final String? currentImageUrl;
  final String storagePath;
  final String imageType;
  final Function(String) onImageUploaded;

  const ImageUploadField({
    super.key,
    required this.label,
    this.currentImageUrl,
    required this.storagePath,
    required this.imageType,
    required this.onImageUploaded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ImageUploadWidget(
          currentImageUrl: currentImageUrl,
          storagePath: storagePath,
          imageType: imageType,
          onImageUploaded: onImageUploaded,
        ),
      ],
    );
  }
}
