import 'package:flutter/material.dart';
import 'package:hacker_news/Models/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.author ?? ''),
          Text(comment.content ?? ''),
        ],
      ),
    );
  }
}
