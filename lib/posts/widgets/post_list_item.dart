import 'package:flutter/material.dart';
import 'package:infinitelistapp/posts/posts.dart';
import 'package:infinitelistapp/posts/models/post.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  // final Articles? articles;

  PostListItem({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text(
          '${post.id
          // articles!.urlToImage
          }',
          style: textTheme.bodySmall,
        ),
        title: Text(post.title
            //articles!.title
            ),
        isThreeLine: true,
        subtitle: Text(post.body
            // articles!.description
            ),
        dense: true,
      ),
    );
  }
}
