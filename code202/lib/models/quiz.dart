import 'package:code202/models/question.dart';

/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-28 14:42:46
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-30 12:39:05
/// @FilePath: lib/models/quiz.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class Quiz {
  final String id;
  final String badge;
  final List<Question> questions;

  Quiz({required this.id, required this.badge, required this.questions});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'badge': this.badge,
      'questions': this.questions,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'].toString(),
      badge: map['badge'].toString(),
      questions: List<Question>.from(map['questions']
          .map((e) => Question.fromMap(Map<String, dynamic>.from(e)))),
    );
  }
}
