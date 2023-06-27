import 'package:flutter/material.dart';
import 'package:my_infinite_bloc/posts/model/model.dart';


class PostListItem extends StatelessWidget {
  const PostListItem({super.key,required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("${post.id}"),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
    );
  }
}