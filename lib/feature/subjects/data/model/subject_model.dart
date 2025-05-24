import 'package:hive/hive.dart';
import 'package:kursovaya_notebook/feature/link/data/model/link_data_model.dart';

part 'subject_model.g.dart';

@HiveType(typeId: 2)
class Subject extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  String? teacher;

  @HiveField(3)
  String? assessmentType;

  @HiveField(4)
  List<LinkData> links;

  Subject({
    required this.id,
    required this.name,
    this.teacher,
    this.assessmentType,
    this.links = const [],
  });

  Subject copyWith({
    String? id,
    String? name,
    String? teacher,
    String? assessmentType,
    List<LinkData>? links,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      teacher: teacher ?? this.teacher,
      assessmentType: assessmentType ?? this.assessmentType,
      links: links ?? this.links,
    );
  }
}
