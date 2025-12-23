class CvEntity {
  final String id;
  final String url;
  final String filename;
  final DateTime uploadedAt;
  final int? fileSize;

  const CvEntity({
    required this.id,
    required this.url,
    required this.filename,
    required this.uploadedAt,
    this.fileSize,
  });
}
