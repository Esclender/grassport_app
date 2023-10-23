import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/charge/bloc.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class LocationTag extends StatelessWidget {
  final int ind;
  final Widget leading;
  final String department;
  final String location;
  const LocationTag({
    super.key,
    required this.leading,
    required this.department,
    required this.location,
    required this.ind,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ChargeRoute>().changeRoute(routeHomeApp);
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, routeCharge);
      },
      style: TextButton.styleFrom(
        foregroundColor: c9,
      ),
      child: Row(
        children: [
          leading,
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align children to the left
              children: [
                Text(
                  department,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 14,
                    color: c10,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
