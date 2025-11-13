class SkillModel {
  final String name;
  final double level; // 0.0 to 1.0
  final String icon; // Can be IconData name or asset path
  final String category; // e.g., "Frontend", "Backend", "Tools"
  final String? description;

  SkillModel({
    required this.name,
    required this.level,
    required this.icon,
    required this.category,
    this.description,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      name: json['name'] as String,
      level: (json['level'] as num).toDouble(),
      icon: json['icon'] as String,
      category: json['category'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
      'icon': icon,
      'category': category,
      'description': description,
    };
  }

  SkillModel copyWith({
    String? name,
    double? level,
    String? icon,
    String? category,
    String? description,
  }) {
    return SkillModel(
      name: name ?? this.name,
      level: level ?? this.level,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }
}
