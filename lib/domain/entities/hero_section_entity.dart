/// Entity representing the Hero Section content
class HeroSectionEntity {
  final String id;
  final String greeting;
  final String name;
  final String title;
  final String subtitle;
  final String description;
  final String ctaButtonText;
  final String ctaButtonLink;
  final String? profileImageUrl;
  final String? backgroundImageUrl;
  final String? videoUrl;
  final bool isActive;

  const HeroSectionEntity({
    required this.id,
    required this.greeting,
    required this.name,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.ctaButtonText,
    required this.ctaButtonLink,
    this.profileImageUrl,
    this.backgroundImageUrl,
    this.videoUrl,
    this.isActive = true,
  });

}
