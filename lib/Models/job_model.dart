class Job {
  final int id;
  final String title;
  final String preTitle;
  final String? category;
  final String description;
  final String requirements;
  final String email;
  final String address;
  final DateTime deadline;
  final DateTime publishDate;

  Job({
    required this.id,
    required this.title,
    required this.preTitle,
    this.category,
    required this.description,
    required this.requirements,
    required this.email,
    required this.address,
    required this.deadline,
    required this.publishDate,
  });
}
