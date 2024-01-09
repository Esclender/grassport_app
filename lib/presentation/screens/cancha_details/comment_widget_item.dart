// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class CommentWidget extends StatefulWidget {
  Comment commentInfo;
  bool isDetailed;
  bool isDetailedReply;
  Function? updateFun;

  CommentWidget({
    super.key,
    required this.commentInfo,
    required this.isDetailed,
    this.isDetailedReply = false,
    this.updateFun,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  TextEditingController _replyController = TextEditingController();

  ApiClient myClient = ApiClient();

  Future<void> sentComment() async {
    await myClient.saveComment(
      placeId: widget.commentInfo.placeId,
      comment: _replyController.text,
      commentToReplyId: widget.commentInfo.id,
      isReply: 'true',
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Comment> replies = widget.commentInfo.replies;
    Comment info = widget.commentInfo;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(info.profilePicture),
      ),
      isThreeLine: true,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info.name,
            style: TextStyle(color: c16, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: c16.withOpacity(0.8),
                  ),
                ),
                const Gap(8),
                Text(
                  info.tiempoPublicado,
                  style: TextStyle(color: c16, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
      subtitle: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(info.comment),
            // Add your extra widget below the subtitle
            const SizedBox(height: 8),
            widget.isDetailed || widget.isDetailedReply
                ? Container()
                : InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        routeCanchaReplies,
                        arguments: info,
                      );
                    },
                    child: Text(
                      '${replies.length} Respuestas',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
          ],
        ),
      ),
      trailing: !widget.isDetailed || widget.isDetailedReply
          ? null
          : InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: c8,
                    duration: const Duration(days: 1),
                    content: SizedBox(
                      height: 80, // Set a fixed height for the SnackBar content
                      child: ListView(
                        children: [
                          Text('Respondiendo a ${info.name}'),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _replyController,
                                  decoration: InputDecoration(
                                    hintText: 'Escribe tu respuesta',
                                    hintStyle: TextStyle(color: c1),
                                  ),
                                  onSubmitted: (value) async {
                                    //await widget.updateFun!();

                                    try {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      await sentComment();
                                    } finally {
                                      await widget.updateFun!();
                                    }
                                  },
                                  autofocus: true,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: c1,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(Icons.reply),
            ),
    );
  }
}
