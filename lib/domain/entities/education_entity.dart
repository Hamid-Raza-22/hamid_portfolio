/// Domain entity representing an education entry.
class EducationEntity {
  final String id;
  final String degree;
  final String institution;
  final String duration;
  final String? cgpa;
  final String? specialization;
  final String? project;

  const EducationEntity({
    required this.id,
    required this.degree,
    required this.institution,
    required this.duration,
    this.cgpa,
    this.specialization,
    this.project,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
