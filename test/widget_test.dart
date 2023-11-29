import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grassport_app/main.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/charge/bloc.dart';
import 'package:grassport_app/presentation/bloc/device_current_location/blocs.dart';
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
import 'package:grassport_app/presentation/screens/StartingApp/previews.dart';
import 'package:grassport_app/presentation/screens/StartingApp/start.dart';
import 'package:grassport_app/presentation/screens/chargeScreens/main_charge.dart'; // Update with the actual import path of your main.dart

void main() {
  testWidgets('Initial screen is displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    Widget getBlocs() {
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
          BlocProvider(create: (context) => DeviceGpsLocation()),
        ],
        child: const Previews(),
      );
    }

    await tester.pumpWidget(getBlocs());
  });
}
