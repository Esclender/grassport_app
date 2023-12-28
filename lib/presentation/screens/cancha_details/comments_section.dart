import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/screens/cancha_details/comment_widget_item.dart';
import 'package:grassport_app/presentation/styles/boxx_shadows.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class CommentsSection extends StatefulWidget {
  final int commentsCount;
  final List<Comment> comments;

  CommentsSection({
    super.key,
    required this.commentsCount,
    required this.comments,
  });

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Comentarios ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: c7,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: c8,
                shape: BoxShape.circle,
                boxShadow: [neoShadow],
              ),
              child: Text(
                "${widget.commentsCount}",
                style: TextStyle(color: c1, fontSize: 20),
              ),
            ),
          ],
        ),
        const Gap(8),
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: widget.commentsCount,
            itemBuilder: (context, index) {
              Comment comment = widget.comments[index];

              return CommentWidget(
                name: comment.name,
                comment: comment.comment,
                profilePicture: comment.profilePicture,
                isReply: false,
                isDetailed: false,
              );
            },
          ),
        ),
        Row(
          children: [
            SearchBar(
              controller: _commentController,
              backgroundColor: MaterialStateProperty.all(c2),
              elevation: MaterialStateProperty.all(2.0),
              constraints: const BoxConstraints(maxWidth: 280, minHeight: 50),
              hintText: 'Escribe un comentario',
            ),
            const Gap(20),
            IconButton.filled(
              onPressed: () {},
              icon: Icon(Icons.send),
              style: TextButton.styleFrom(backgroundColor: c8),
            )
          ],
        )
      ],
    );
  }
}
