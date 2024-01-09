import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/bloc/home_view_selected/bloc.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class DashboardMyPlaces extends StatelessWidget {
  List<Comment> comments = [
    // Comment(
    //   replies: [],
    //   name: "Esclender",
    //   comment:
    //       "Eu proident nostrud ex sunt Lorem anim duis esse consequat. Ullamco amet qui velit quis ad ipsum officia officia magna. Qui adipisicing commodo irure dolore cillum qui anim culpa nulla tempor do ut. Magna exercitation ullamco sint aute pariatur commodo cupidatat id quis esse sit ex. Culpa adipisicing esse eu ipsum culpa.",
    //   profilePicture:
    //       'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    // ),
    // Comment(
    //   replies: [],
    //   name: "Esclender",
    //   comment: "Comentario",
    //   profilePicture:
    //       'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    // ),
    // Comment(
    //   replies: [],
    //   name: "Esclender",
    //   comment: "Comentario",
    //   profilePicture:
    //       'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    // ),
    // Comment(
    //   replies: [],
    //   name: "Esclender",
    //   comment: "Comentario",
    //   profilePicture:
    //       'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    // ),
    // Comment(
    //   replies: [],
    //   name: "Esclender",
    //   comment: "Comentario",
    //   profilePicture:
    //       'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    // ),
    // Comment(
    //   replies: [],
    //   name: "Esclender",
    //   comment: "Comentario",
    //   profilePicture:
    //       'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    // ),
  ];

  DashboardMyPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    HomeView selectedIcon = context.watch<HomeView>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  selectedIcon.changeView(0);

                  Navigator.pushNamed(context, routeCharge);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: c1,
                ),
                label: Text(
                  ' Volver',
                  style: TextStyle(color: c1),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: c15,
                      offset: Offset(0, 0.7),
                      blurRadius: 2,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    'https://placekitten.com/200/200',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          RichText(
            text: const TextSpan(
              text: 'Bienvenido, \n',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'Esclender',
                  style: TextStyle(fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildDashboard(),
          const Gap(30),
          _buildRecentsComments(),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: c19,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _dashboardTags('Canchas', Icons.sports_soccer, 1),
          _dashboardTags('Comentarios', Icons.comment, 40),
          _dashboardTags('Rating', Icons.star, null, rating: 4.8),
        ],
      ),
    );
  }

  Widget _buildRecentsComments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comentarios de tus canchas',
          style:
              TextStyle(fontWeight: FontWeight.w200, color: c1, fontSize: 20),
        ),
        const Gap(10),
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: c19,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        NetworkImage('https://placekitten.com/200/200'),
                  ),
                  title: Text(
                    'Cancha Aurora Salta Altamar',
                    style: TextStyle(color: c1, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: _buildCommentsByCancha(comments.length, comments),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _dashboardTags(String title, IconData icon, int? amount,
      {double rating = 5.0}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: c1,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Row(
          children: [
            Icon(
              icon,
              color: c1,
            ),
            const Gap(5),
            Text(
              '${amount ?? rating}',
              style: TextStyle(color: c1, fontSize: 20),
            )
          ],
        )
      ],
    );
  }

  Widget _buildCommentsByCancha(int count, List<Comment> comments) {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, ind) {
        return ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(comments[ind].profilePicture),
          ),
          title: Text(
            comments[ind].name,
            style: TextStyle(
              color: c1,
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            comments[ind].comment,
            style: TextStyle(color: c1, fontWeight: FontWeight.w200),
          ),
          isThreeLine: true,
        );
      },
    );
  }
}
