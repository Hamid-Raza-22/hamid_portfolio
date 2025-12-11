/// Domain entity representing profile/about information.
class ProfileEntity {
  final String name;
  final String title;
  final String experience;
  final String summary;
  final String workPreferences;
  final String location;
  final String languages;

  const ProfileEntity({
    required this.name,
    required this.title,
    required this.experience,
    required this.summary,
    required this.workPreferences,
    required this.location,
    required this.languages,
  });
}
