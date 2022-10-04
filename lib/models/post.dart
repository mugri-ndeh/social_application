import 'dart:convert';

import 'package:chat_application/models/comments.dart';
import 'package:chat_application/models/likes.dart';
import 'package:chat_application/models/user.dart';

class Post {
  String? postId;
  String? caption;
  String? imagePath;
  List<Comment> comments;
  List<Like> likes;
  UserModel poster;
  DateTime date;
  Post({
    this.postId,
    this.caption,
    this.imagePath,
    required this.comments,
    required this.likes,
    required this.poster,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (postId != null) {
      result.addAll({'postId': postId});
    }
    if (caption != null) {
      result.addAll({'caption': caption});
    }
    if (imagePath != null) {
      result.addAll({'imagePath': imagePath});
    }
    result.addAll({'comments': comments.map((x) => x.toMap()).toList()});
    result.addAll({'likes': likes.map((x) => x.toMap()).toList()});
    result.addAll({'poster': poster.toMap()});
    result.addAll({'date': date.millisecondsSinceEpoch});

    return result;
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'],
      caption: map['caption'],
      imagePath: map['imagePath'],
      comments:
          List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
      likes: List<Like>.from(map['likes']?.map((x) => Like.fromMap(x))),
      poster: UserModel.fromMap(map['poster']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
