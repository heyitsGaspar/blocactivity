class Activity {
  final String name;
  final String description;
  final bool isActive;
  final bool isFinished;

  Activity({
    required this.name,
    required this.description,
    this.isActive = false,
    this.isFinished = false,
  });

  Activity copyWith({
    String? name,
    String? description,
    bool? isActive,
    bool? isFinished,
  }) {
    return Activity(
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
