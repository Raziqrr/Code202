/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-28 14:28:57
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-29 21:57:29
/// @FilePath: lib/models/sub_lessons.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class Sublessons {
  final String id;
  final String title;
  final String lessonDescription;
  final String imagePath;
  final String quizId;
  final List<String> contents;
  final List<Map<String, dynamic>> references;

  Sublessons(
      {required this.id,
      required this.title,
      required this.lessonDescription,
      this.imagePath = "",
      required this.quizId,
      required this.contents,
      this.references = const []});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'lessonDescription': this.lessonDescription,
      'imagePath': this.imagePath,
      'quizId': this.quizId,
      'contents': this.contents,
      'references': this.references,
    };
  }

  factory Sublessons.fromMap(Map<String, dynamic> map) {
    return Sublessons(
      id: map['id'].toString(),
      title: map['title'].toString(),
      lessonDescription: map['lessonDescription'].toString(),
      imagePath: map['imagePath'].toString(),
      quizId: map['quizId'].toString(),
      contents: List<String>.from(map["contents"]),
      references: List<Map<String, dynamic>>.from(map["references"]),
    );
  }
}
