import 'package:flutter/material.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/screens/cancha_details/comment_widget_item.dart';

class CommentRepliesDetailed extends StatefulWidget {
  final Comment comment;

  const CommentRepliesDetailed({
    super.key,
    required this.comment,
  });

  @override
  State<CommentRepliesDetailed> createState() => _CommentRepliesDetailedState();
}

class _CommentRepliesDetailedState extends State<CommentRepliesDetailed> {
  ApiClient myClient = ApiClient();
  late List<Comment> replies;

  @override
  void initState() {
    setReplies();
    super.initState();
  }

  void setReplies() {
    setState(() {
      replies = widget.comment.replies;
    });
  }

  Future<void> updateComments() async {
    CanchaInfo updatedInfo =
        await myClient.getNearLocationsDetails(widget.comment.placeId);

    for (Comment comment in updatedInfo.comments) {
      if (comment.id == widget.comment.id) {
        setState(() {
          replies = comment.replies;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommentWidget(
                commentInfo: widget.comment,
                isDetailed: true,
                updateFun: updateComments,
              ),
              const Divider(),
              const Row(
                children: [
                  Text(
                    'Respuestas',
                  )
                ],
              ),
              Column(
                children: replies.map(
                  (comment) {
                    return CommentWidget(
                      commentInfo: comment,
                      isDetailed: false,
                      isDetailedReply: true,
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
