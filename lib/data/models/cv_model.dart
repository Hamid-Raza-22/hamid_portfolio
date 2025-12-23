import '../../domain/entities/cv_entity.dart';

class CvModel extends CvEntity {
  const CvModel({
    required super.id,
    required super.url,
    required super.filename,
    required super.uploadedAt,
    super.fileSize,
  });

  factory CvModel.fromJson(Map<String, dynamic> json, String id) {
    return CvModel(
      id: id,
      url: json['url'] as String? ?? '',
      filename: json['filename'] as String? ?? '',
      uploadedAt: json['uploadedAt'] != null
          ? DateTime.parse(json['uploadedAt'] as String)
          : DateTime.now(),
      fileSize: json['fileSize'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'filename': filename,
      'uploadedAt': uploadedAt.toIso8601String(),
      'fileSize': fileSize,
    };
  }

  factory CvModel.fromEntity(CvEntity entity) {
    return CvModel(
      id: entity.id,
      url: entity.url,
      filename: entity.filename,
      uploadedAt: entity.uploadedAt,
      fileSize: entity.fileSize,
    );
  }

  CvEntity toEntity() {
    return CvEntity(
      id: id,
      url: url,
      filename: filename,
      uploadedAt: uploadedAt,
      fileSize: fileSize,
    );
  }
}
