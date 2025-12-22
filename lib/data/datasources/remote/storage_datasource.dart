import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

/// Storage data source interface for Firebase Storage operations.
abstract class StorageDataSource {
  /// Upload image and return download URL
  Future<String> uploadImage({
    required Uint8List imageBytes,
    required String path,
    required String fileName,
    String? contentType,
  });

  /// Delete image from storage
  Future<void> deleteImage(String imageUrl);

  /// Get optimized image URL with size parameters
  String getOptimizedImageUrl(String originalUrl, {int? width, int? height});
}

/// Firebase Storage implementation
class StorageDataSourceImpl implements StorageDataSource {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String> uploadImage({
    required Uint8List imageBytes,
    required String path,
    required String fileName,
    String? contentType,
  }) async {
    try {
      // Create reference with path
      final ref = _storage.ref().child(path).child(fileName);

      // Set metadata for web optimization
      final metadata = SettableMetadata(
        contentType: contentType ?? 'image/png',
        cacheControl: 'public, max-age=31536000', // Cache for 1 year
        customMetadata: {
          'uploadedAt': DateTime.now().toIso8601String(),
        },
      );

      // Upload with metadata
      final uploadTask = ref.putData(imageBytes, metadata);

      // Monitor upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        debugPrint('Upload progress: ${(progress * 100).toStringAsFixed(1)}%');
      });

      // Wait for completion
      final snapshot = await uploadTask;

      // Get download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();
      debugPrint('Image uploaded successfully: $downloadUrl');

      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteImage(String imageUrl) async {
    try {
      if (imageUrl.isEmpty || !imageUrl.contains('firebase')) {
        return; // Not a Firebase Storage URL
      }

      final ref = _storage.refFromURL(imageUrl);
      await ref.delete();
      debugPrint('Image deleted successfully: $imageUrl');
    } catch (e) {
      debugPrint('Error deleting image: $e');
      // Don't rethrow - deletion failure shouldn't break the flow
    }
  }

  @override
  String getOptimizedImageUrl(String originalUrl, {int? width, int? height}) {
    // For Firebase Storage, we return the original URL
    // Image optimization can be done client-side or via Cloud Functions
    return originalUrl;
  }
}

/// Image upload configuration with predefined sizes
class ImageConfig {
  static const Map<String, ImageSize> sizes = {
    'profile': ImageSize(width: 400, height: 400, aspectRatio: 1.0),
    'hero': ImageSize(width: 1920, height: 1080, aspectRatio: 16 / 9),
    'portfolio': ImageSize(width: 800, height: 600, aspectRatio: 4 / 3),
    'service': ImageSize(width: 200, height: 200, aspectRatio: 1.0),
    'icon': ImageSize(width: 64, height: 64, aspectRatio: 1.0),
    'thumbnail': ImageSize(width: 300, height: 300, aspectRatio: 1.0),
  };

  static ImageSize getSize(String type) {
    return sizes[type] ?? sizes['thumbnail']!;
  }
}

class ImageSize {
  final int width;
  final int height;
  final double aspectRatio;

  const ImageSize({
    required this.width,
    required this.height,
    required this.aspectRatio,
  });
}
