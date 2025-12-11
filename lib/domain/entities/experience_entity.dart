/// Domain entity representing a work experience entry.
class ExperienceEntity {
  final String id;
  final String title;
  final String company;
  final String location;
  final String duration;
  final List<String> highlights;

  const ExperienceEntity({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.duration,
    required this.highlights,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperienceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
