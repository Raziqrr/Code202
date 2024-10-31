/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-28 14:44:04
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-28 14:46:19
/// @FilePath: lib/models/question.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class Question {
  final String id;
  final String questionTitle;
  final List<String> answerChoices;
  final String correctAnswer;

  Question(
      {required this.id,
      required this.questionTitle,
      required this.answerChoices,
      required this.correctAnswer});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'questionTitle': this.questionTitle,
      'answerChoices': this.answerChoices,
      'correctAnswer': this.correctAnswer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'].toString(),
      questionTitle: map['questionTitle'].toString(),
      answerChoices: List<String>.from(map["answerChoices"]),
      correctAnswer: map['correctAnswer'].toString(),
    );
  }
}
