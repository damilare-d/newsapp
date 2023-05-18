import 'package:flutter/material.dart';
import 'package:infinitelistapp/posts/posts.dart';
import 'package:infinitelistapp/posts/models/post.dart';

class PostListItem extends StatelessWidget {
  PostListItem({super.key, this.post, this.articles});

  Post? post;
  Articles? articles;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text(
          '${
          //post.id
          articles!.urlToImage}',
          style: textTheme.bodySmall,
        ),
        title: Text(
            // post.title
            articles!.title),
        isThreeLine: true,
        subtitle: Text(
            // post.body
            articles!.description),
        dense: true,
      ),
    );
  }
}
