import 'package:chat_application/models/comments.dart';
import 'package:chat_application/services/post_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

import '../../models/likes.dart';
import '../../models/post.dart';

class HomeProvider with ChangeNotifier {
  final postServices = PostServices();

  List<Post> posts = [];

  bool isLoading = false;

  getAllPosts() {
    isLoading = true;
    postServices.getAllPosts().then((value) {
      if (value is List<Post>) {
        posts = value;
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return value;
      }
    });
  }

  comment(String commentStr, Post post, String uid) async {
    isLoading = true;

    Comment comment =
        Comment(uid: uid, comment: commentStr, date: DateTime.now());
    post.comments.add(comment);
    await postServices.commentOnPost(post).then((value) {
      isLoading = false;

      notifyListeners();
      return value;
    });
  }

  like(Post post, String uid) async {
    isLoading = true;

    Like like = Like(uid: uid, date: DateTime.now());
    post.likes.add(like);
    postServices.likePost(post).then((value) {
      isLoading = false;

      notifyListeners();
      return value;
    });
  }
}
