class Subject {
  final String name;
  String? teacher;
  String? assessmentType;
  List<String> links;

  Subject({
    required this.name,
    this.teacher,
    this.assessmentType,
    this.links = const [],
  });

  Subject copyWith({
    String? name,
    String? teacher,
    String? assessmentType,
    List<String>? links,
  }) {
    return Subject(
      name: name ?? this.name,
      teacher: teacher ?? this.teacher,
      assessmentType: assessmentType ?? this.assessmentType,
      links: links ?? this.links,
    );
  }
}
