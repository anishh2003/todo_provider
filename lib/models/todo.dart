// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class ToDo {
  ToDo({
    required this.title,
    required this.description,
    required this.isDone,
  });

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final bool isDone;

  ToDo copyWith({
    String? title,
    String? description,
    bool? isDone,
  }) {
    return ToDo(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}
