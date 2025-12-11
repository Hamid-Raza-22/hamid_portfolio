/// Domain entity representing a certification.
class CertificationEntity {
  final String id;
  final String title;
  final String issuer;
  final String year;

  const CertificationEntity({
    required this.id,
    required this.title,
    required this.issuer,
    required this.year,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CertificationEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
