// ignore_for_file: public_member_api_docs, sort_constructors_first
class ToDo {
  ToDo({
    required this.title,
    required this.description,
    required this.isDone,
  });

  final String title;
  final String description;
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
