/// Domain entity representing a navigation item.
class NavItemEntity {
  final String id;
  final String title;
  final String? sectionKey;

  const NavItemEntity({
    required this.id,
    required this.title,
    this.sectionKey,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavItemEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
