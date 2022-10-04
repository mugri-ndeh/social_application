import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/post.dart';

class PostFeed extends StatelessWidget {
  const PostFeed({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          _topPost(context),
          _centerPost(context),
          Divider(
            height: 2,
            thickness: 2,
            color: Theme.of(context).dividerColor,
          ),
          _reactionPost(),
          Divider(
            height: 5,
            thickness: 5,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }

  Expanded _centerPost(BuildContext context) {
    return Expanded(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: post.imagePath == null
              ? Text(post.caption!)
              : CachedNetworkImage(
                  placeholder: (context, lol) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  imageUrl: post.imagePath!,
                  fit: BoxFit.fitWidth,
                ),
        ),
      ]),
    );
  }

  Padding _reactionPost() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 60,
        child: Center(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.thumb_up),
                  Text('${post.likes.length} Like')
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.comment),
                  Text('${post.comments.length} Comment')
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _topPost(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 55,
        child: Row(
          children: [
            CircleAvatar(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
            )),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.poster.username,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    '${post.date.day} ${post.date.month} ${post.date.year}',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
