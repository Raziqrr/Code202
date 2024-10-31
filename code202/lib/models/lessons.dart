import 'package:code202/models/sub_lessons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-28 14:27:35
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-30 10:34:21
/// @FilePath: lib/models/lessons.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class Lessons {
  final String id;
  final String name;
  final String shortDescription;
  final List<Sublessons> sublessons;

  Lessons(
      {required this.id,
      required this.name,
      required this.shortDescription,
      required this.sublessons});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'shortDescription': this.shortDescription,
      'sublessons': this.sublessons,
    };
  }

  factory Lessons.fromMap(Map<String, dynamic> map) {
    return Lessons(
      id: map['id'].toString(),
      name: map['name'].toString(),
      shortDescription: map['shortDescription'].toString(),
      sublessons: List<Sublessons>.from(
        (map['sublessons'] as List<dynamic>).map(
          (e) => Sublessons.fromMap(Map<String, dynamic>.from(e)),
        ),
      ),
    );
  }

  Icon getIcon() {
    switch (this.name) {
      case "Intelligence":
        return Icon(CupertinoIcons.square_stack_3d_up_fill);
      default:
        return Icon(Icons.warning_rounded);
    }
  }
}
