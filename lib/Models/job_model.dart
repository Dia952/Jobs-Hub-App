class Job {
  final int id;
  final String title;
  final String description;
  final String requirements;
  final String email;
  final String address;
  final DateTime deadline;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.requirements,
    required this.email,
    required this.address,
    required this.deadline,
  });
}
