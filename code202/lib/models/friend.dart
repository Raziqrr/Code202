/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-29 04:19:49
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-29 04:20:47
/// @FilePath: lib/models/friend.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class Friend {
  String name;
  String uid;
  String token;

  Friend({required this.name, required this.uid, required this.token});

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'uid': this.uid,
      'token': this.token,
    };
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      name: map['name'].toString(),
      uid: map['uid'].toString(),
      token: map['token'].toString(),
    );
  }
}
