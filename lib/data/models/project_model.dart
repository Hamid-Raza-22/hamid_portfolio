class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String? longDescription;
  final String imageUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String category; // e.g., "Mobile", "Web", "Desktop"
  final DateTime? completedDate;
  final bool isFeatured;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    this.longDescription,
    required this.imageUrl,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    required this.category,
    this.completedDate,
    this.isFeatured = false,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      longDescription: json['longDescription'] as String?,
      imageUrl: json['imageUrl'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      githubUrl: json['githubUrl'] as String?,
      liveUrl: json['liveUrl'] as String?,
      category: json['category'] as String,
      completedDate: json['completedDate'] != null
          ? DateTime.parse(json['completedDate'] as String)
          : null,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'longDescription': longDescription,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'githubUrl': githubUrl,
      'liveUrl': liveUrl,
      'category': category,
      'completedDate': completedDate?.toIso8601String(),
      'isFeatured': isFeatured,
    };
  }

  ProjectModel copyWith({
    String? id,
    String? title,
    String? description,
    String? longDescription,
    String? imageUrl,
    List<String>? technologies,
    String? githubUrl,
    String? liveUrl,
    String? category,
    DateTime? completedDate,
    bool? isFeatured,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      longDescription: longDescription ?? this.longDescription,
      imageUrl: imageUrl ?? this.imageUrl,
      technologies: technologies ?? this.technologies,
      githubUrl: githubUrl ?? this.githubUrl,
      liveUrl: liveUrl ?? this.liveUrl,
      category: category ?? this.category,
      completedDate: completedDate ?? this.completedDate,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
