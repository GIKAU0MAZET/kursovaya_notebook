
import 'package:hive/hive.dart';

part 'schedule_model.g.dart';

@HiveType(typeId: 4)
class ScheduleEvent extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int day;

  @HiveField(4)
  final int pairNumber;

  ScheduleEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.day,
    required this.pairNumber,
  });
}
