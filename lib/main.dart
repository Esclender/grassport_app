import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/charge/bloc.dart';
import 'package:grassport_app/presentation/bloc/locations/blocs.dart';
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
      initialRoute: routeStartApp,
      theme: ThemeData(
        fontFamily: 'blinker',
        useMaterial3: true,
      ),
      home: const StartView(),
    );
  }
}
