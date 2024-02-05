import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(String source) =>
      ToDo.fromMap(json.decode(source) as Map<String, dynamic>);
}
