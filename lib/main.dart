import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/charge/bloc.dart';
import 'package:grassport_app/presentation/bloc/home_is_search/bloc.dart';
import 'package:grassport_app/presentation/bloc/home_profile/bloc.dart';
import 'package:grassport_app/presentation/bloc/home_view_selected/bloc.dart';
import 'package:grassport_app/presentation/bloc/locations/blocs.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/bloc/nearCanchas/blocs.dart';
import 'package:grassport_app/presentation/bloc/notifications/bloc.dart';
import 'package:grassport_app/presentation/bloc/savedLocations/blocs.dart';
import 'package:grassport_app/presentation/bloc/startAppBloc/blocs.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/screens/StartingApp/start.dart';

void main() {
  runApp(const BlocsProvider());
}

class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NextSwipers()),
        BlocProvider(create: (context) => SelectLocation()),
        BlocProvider(create: (context) => ChargeRoute()),
        BlocProvider(create: (context) => NearCanchas()),
        BlocProvider(create: (context) => SavedLocations()),
        BlocProvider(create: (context) => IsSearch()),
        BlocProvider(create: (context) => IsProfile()),
        BlocProvider(create: (context) => HomeView()),
        BlocProvider(create: (context) => Notifications()),
        BlocProvider(create: (context) => LoggedUser()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: MyRouters.generateRoute,
      initialRoute: routeStartApp, //routeStartApp
      theme: ThemeData(
        fontFamily: 'blinker',
        useMaterial3: true,
      ),
      home: const StartView(), //
    );
  }
}
