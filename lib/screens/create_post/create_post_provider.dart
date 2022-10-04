import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

import '../../models/post.dart';
import '../../services/post_services.dart';

class CreatePostProvider with ChangeNotifier {
  bool isLoading = false;
  final postServices = PostServices();
  PlatformFile? img;

  TextEditingController caption = TextEditingController();

  Future<dynamic> addPost(Post post, PlatformFile? image) async {
    isLoading = true;

    postServices.createPost(post, image).then((value) {
      isLoading = false;
      notifyListeners();
      return value;
    });
  }
}
