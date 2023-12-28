import 'package:flutter/material.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/screens/cancha_details/comment_widget_item.dart';

class CommentRepliesDetailed extends StatefulWidget {
  const CommentRepliesDetailed({super.key});

  @override
  State<CommentRepliesDetailed> createState() => _CommentRepliesDetailedState();
}

class _CommentRepliesDetailedState extends State<CommentRepliesDetailed> {
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
                name: 'Esclender',
                comment:
                    'Eu proident nostrud ex sunt Lorem anim duis esse consequat. Ullamco amet qui velit quis ad ipsum officia officia magna. Qui adipisicing commodo irure dolore cillum qui anim culpa nulla tempor do ut. Magna exercitation ullamco sint aute pariatur commodo cupidatat id quis esse sit ex. Culpa adipisicing esse eu ipsum culpa.',
                profilePicture:
                    'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
                isReply: false,
                isDetailed: true,
              ),
              Divider(),
              const Row(
                children: [
                  Text(
                    'Respuestas',
                  )
                ],
              ),
              Column(
                children: replies.map((comment) {
                  return CommentWidget(
                    name: comment.name,
                    comment: comment.comment,
                    profilePicture: comment.profilePicture,
                    isReply: true,
                    isDetailed: false,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
