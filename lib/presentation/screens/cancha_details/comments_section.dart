import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/screens/cancha_details/comment_widget_item.dart';
import 'package:grassport_app/presentation/styles/boxx_shadows.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class CommentsSection extends StatefulWidget {
  final String placeId;
  final List<Comment> comments;
  final bool isOwner;

  const CommentsSection({
    super.key,
    required this.comments,
    required this.placeId,
    this.isOwner = false,
  });

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  TextEditingController _commentController = TextEditingController();
  late List<Comment> allComments;

  ApiClient myClient = ApiClient();

  @override
  void initState() {
    setMainComments();
    super.initState();
  }

  postCommentOrReply() async {}

  setMainComments() {
    setState(() {
      allComments = widget.comments;
    });
  }

  Future<void> sentComment() async {
    await myClient.saveComment(
      placeId: widget.placeId,
      comment: _commentController.text,
    );

    _commentController.clear();
  }

  Future<void> updateComments() async {
    CanchaInfo updatedInfo =
        await myClient.getNearLocationsDetails(widget.placeId);

    setState(() {
      allComments = updatedInfo.comments;
    });
  }

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
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: c8,
                shape: BoxShape.circle,
                boxShadow: [neoShadow],
              ),
              child: Text(
                "${allComments.length}",
                style: TextStyle(color: c1, fontSize: 20),
              ),
            ),
          ],
        ),
        const Gap(8),
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: allComments.length,
            itemBuilder: (context, index) {
              Comment comment = allComments[index];

              return CommentWidget(
                commentInfo: comment,
                isDetailed: false,
              );
            },
          ),
        ),
        _buildCommentField(),
      ],
    );
  }

  Widget _buildCommentField() {
    return Row(
      children: [
        SizedBox(
          height: 50,
          width: 280,
          child: TextField(
            controller: _commentController,
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
          onTap: () async {
            try {
              await sentComment();
            } finally {
              await updateComments();
            }
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
    );
  }
}
