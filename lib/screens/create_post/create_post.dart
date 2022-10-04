import 'dart:typed_data';

import 'package:chat_application/screens/auth/auth_provider.dart';
import 'package:chat_application/util/app_interactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/post.dart';
import '../../services/post_services.dart';
import '../../util/widgets/image_placeholder.dart';
import '../../util/widgets/input.dart';
import 'create_post_provider.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CreatePostProvider(),
        child: Consumer<CreatePostProvider>(builder: (_, provider, __) {
          return Scaffold(
              body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Text(
                  'Please fill in all fields',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const SizedBox(height: 18),
              InputField(
                controller: provider.caption,
                hint: 'Caption',
              ),
              const SizedBox(height: 16),
              Center(
                child: Text('Add Image',
                    style: Theme.of(context).textTheme.headline5),
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //img 1
                GestureDetector(
                  onTap: () async {
                    PostServices.selectFile().then((value) {
                      provider.img = value;
                    });
                  },
                  child: provider.img == null
                      ? imgplace(context: context, height: 100, width: 100)
                      : Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          child: Image.memory(
                            Uint8List.fromList(provider.img!.bytes!),
                            fit: BoxFit.contain,
                          )),
                ),
              ]),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                    child: const Text('Done'),
                    onPressed: () async {
                      Post post = Post(
                          caption: provider.caption.text,
                          date: DateTime.now(),
                          comments: [],
                          likes: [],
                          poster: context.read<Authentication>().loggedUser!);
                      provider.addPost(post, provider.img).then((value) {
                        (value is String)
                            ? AppInteractions.showErrorSnackBar(context, value)
                            : Navigator.pop(context);
                      });
                    }),
              ),
            ]),
          ));
        }));
  }
}
