import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grassport_app/presentation/components/home_badget.dart';
import 'package:grassport_app/presentation/screens/home_app/home_app_layers/map_and_modals.dart';
import 'package:grassport_app/presentation/screens/home_app/home_app_layers/search_layer.dart';
import 'package:grassport_app/presentation/screens/home_app/home_app_layers/second_layer.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: c8,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: const Scaffold(
          body: Stack(
            children: [
              MainAppHomeLayer(),
              HomeSearchList(),
              SecondLayer(),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: HomeBadget(),
          ),
        ),
      ),
    );
  }
}
