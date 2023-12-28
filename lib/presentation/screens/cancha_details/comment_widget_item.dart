// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class CommentWidget extends StatefulWidget {
  String name;
  String comment;
  String profilePicture;
  bool isReply;
  bool isDetailed;

  CommentWidget({
    super.key,
    required this.name,
    required this.comment,
    required this.profilePicture,
    required this.isReply,
    required this.isDetailed,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  TextEditingController _replyController = TextEditingController();

  List replies = [
    Comment(
      replies: [],
      name: "Esclender",
      comment: "Comentario",
      profilePicture:
          'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    ),
    Comment(
      replies: [],
      name: "Esclender",
      comment: "Comentario",
      profilePicture:
          'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    ),
    Comment(
      replies: [],
      name: "Esclender",
      comment: "Comentario",
      profilePicture:
          'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.profilePicture),
      ),
      isThreeLine: true,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: TextStyle(color: c16, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Padding(
            padding: EdgeInsets.only(top: 5),
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
                  'Hace 5 minutos',
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
            Text(widget.comment),
            // Add your extra widget below the subtitle
            const SizedBox(height: 8),
            widget.isReply || widget.isDetailed
                ? Container()
                : InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, routeCanchaReplies);
                    },
                    child: Text(
                      '${replies.length} Respuestas',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
          ],
        ),
      ),
      trailing: widget.isReply
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
                        // Use ListView to handle keyboard overflow
                        children: [
                          Text('Respondiendo a ${widget.name}'),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _replyController,
                                  decoration: InputDecoration(
                                    hintText: 'Escribe tu respuesta',
                                    hintStyle: TextStyle(color: c1),
                                  ),
                                  onSubmitted: (value) {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
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
