import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.text,
    required this.isCompleted,
    required this.createdAt,
  });
  @HiveField(0)
  final String id;
  @HiveField(1)
  String text;
  @HiveField(2)
  bool isCompleted;
  @HiveField(3)
  final DateTime createdAt;
}
