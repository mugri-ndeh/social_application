import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post.dart';

class PostServices {
  final _db = FirebaseDatabase.instance;

  static Future<PlatformFile?> selectFile() async {
    PlatformFile? pickedfile;
    var result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
      ],
    );

    if (result == null) return null;

    pickedfile = result.files.first;

    return pickedfile;
  }

  Future<String> uploadFile(
      {required Uint8List data, required String path}) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    var uploadTask = ref.putData(data);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = snapshot.ref.getDownloadURL();
    return urlDownload;
    // return
  }

  Future<File> chooseImage() async {
    final picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    return File(pickedImage!.path);
  }

  Future<dynamic> createPost(Post post, PlatformFile? image) async {
    print('Creating');
    try {
      var result = _db.ref('posts').child(post.poster.uid!).push();
      await result.set(post.toMap());

      var postId = result.key;

      if (image != null) {
        var path = '${post.poster.uid}/posts/$postId/img';
        var imgPath = await uploadFile(data: image.bytes!, path: path);
        await result.update({
          'imagePath': imgPath,
          'id': postId,
        });
      }

      print('Success');

      return post;
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message!;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  likePost(Post post) async {
    try {
      await _db
          .ref('posts')
          .child(post.poster.uid!)
          .child(post.postId!)
          .update(post.toMap());
      return 'success';
    } on FirebaseException catch (e) {
      return e.message!;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  commentOnPost(Post post) async {
    try {
      await _db
          .ref('posts')
          .child(post.poster.uid!)
          .child(post.postId!)
          .update(post.toMap());
      return 'success';
    } on FirebaseException catch (e) {
      return e.message!;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  Future<dynamic> getAllPosts() async {
    try {
      final data = await _db.ref('posts').get();
      List<Post> posts = [];

      for (var element in data.children) {
        for (var post in element.children.toList()) {
          posts.add(Post.fromJson(jsonEncode(post.value)));
        }
      }
      return posts;
    } on FirebaseException catch (e) {
      return e.message!;
    } catch (e) {
      return e.toString();
    }
  }
}
