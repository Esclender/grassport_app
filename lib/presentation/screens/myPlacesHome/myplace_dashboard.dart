import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/home_view_selected/bloc.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class DashboardMyPlaces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeView selectedIcon = context.watch<HomeView>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          // SizedBox(
          //   height: 200.0, // Set a fixed height for the ListView
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: [
          //       Card(
          //         margin: EdgeInsets.all(8.0),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8.0),
          //         ),
          //         color: Colors.blue,
          //         child: const SizedBox(
          //           width: 150.0,
          //           child: Center(
          //             child: Text(
          //               'Item 1',
          //               style: TextStyle(fontSize: 16, color: Colors.white),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
