import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String subjectId;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime createdAt;

  Note({
    required this.id,
    required this.subjectId,
    required this.content,
    required this.createdAt,
  });
}
