import 'dart:convert';

class Comment {
  String uid;
  String comment;
  DateTime date;
  Comment({
    required this.uid,
    required this.comment,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'comment': comment});
    result.addAll({'date': date.millisecondsSinceEpoch});

    return result;
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      uid: map['uid'] ?? '',
      comment: map['comment'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));
}
