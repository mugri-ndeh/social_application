import 'dart:convert';

import 'package:chat_application/models/comments.dart';
import 'package:chat_application/models/likes.dart';

class Post {
  String? postId;
  String? caption;
  String? imagePath;
  List<Comment> comments;
  List<Like> likes;
  Post({
    this.postId,
    this.caption,
    this.imagePath,
    required this.comments,
    required this.likes,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
