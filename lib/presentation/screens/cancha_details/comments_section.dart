import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/screens/cancha_details/comment_widget_item.dart';
import 'package:grassport_app/presentation/styles/boxx_shadows.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class CommentsSection extends StatefulWidget {
  final int commentsCount;
  final List<Comment> comments;
  final bool isOwner;

  CommentsSection({
    super.key,
    required this.commentsCount,
    required this.comments,
    this.isOwner = false,
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
                color: widget.isOwner ? c1 : c7,
              ),
            ),
            const Gap(10),
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
            SizedBox(
              height: 50,
              width: 280,
              child: TextField(
                controller: _commentController,
                style: TextStyle(color: c8),
                decoration: InputDecoration(
                  hintText: 'Escribe un comentario',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.isOwner ? c1 : c8,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.isOwner ? c1 : c8,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(20),
            InkWell(
              onTap: () {
                // Your onPressed logic here
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
                  color: widget.isOwner ? c1 : c8,
                ),
                padding: EdgeInsets.all(10), // Adjust padding as needed
                child: Icon(
                  Icons.send,
                  color: widget.isOwner ? c8 : c1,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
