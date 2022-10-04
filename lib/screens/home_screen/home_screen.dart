import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/navigation.dart';
import '../../models/post.dart';
import '../auth/auth_index.dart';
import '../auth/auth_provider.dart';
import '../create_post/create_post.dart';
import 'home_provider.dart';
import 'widgets/feed.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            push(context, const CreatePost());
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<HomeProvider>(builder: (_, provider, __) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return provider.posts.isEmpty
                ? const Center(
                    child: Text(' No posts found'),
                  )
                : ListView.builder(
                    itemCount: provider.posts.length,
                    itemBuilder: (context, index) {
                      return PostFeed(post: provider.posts[index]);
                    },
                  );
          }
        }),
      ),
    );
  }
}
