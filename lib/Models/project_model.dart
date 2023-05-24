class Project {
  final String title;
  final String description;

  const Project({
    required this.title,
    required this.description,
  });

  Project copy({
    String? title,
    String? description,
  }) =>
      Project(
        title: title ?? this.title,
        description: description ?? this.description,
      );
}
