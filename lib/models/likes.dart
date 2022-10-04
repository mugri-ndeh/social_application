import 'dart:convert';

class Like {
  String uid;
  DateTime date;
  Like({
    required this.uid,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'date': date.millisecondsSinceEpoch});

    return result;
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      uid: map['uid'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) => Like.fromMap(json.decode(source));
}
