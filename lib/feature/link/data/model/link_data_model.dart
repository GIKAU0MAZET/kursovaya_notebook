import 'package:hive/hive.dart';

part 'link_data_model.g.dart';

@HiveType(typeId: 3)
class LinkData extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  LinkData({required this.name, required this.url});
}
