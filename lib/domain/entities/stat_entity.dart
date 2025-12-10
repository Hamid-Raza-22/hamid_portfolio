/// Domain entity representing a statistic/achievement.
class StatEntity {
  final String id;
  final String value;
  final String label;

  const StatEntity({
    required this.id,
    required this.value,
    required this.label,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
