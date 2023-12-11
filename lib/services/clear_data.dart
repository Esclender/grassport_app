import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/google_map_markers/bloc.dart';
import 'package:grassport_app/presentation/bloc/isAdmin/bloc.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/bloc/nearCanchas/blocs.dart';

void clearDataLoggedUser(BuildContext context) {
  context.read<GoogleMapMarkers>().clear();
  context.read<CanchasByInout>().setCanchasByInput([]);
  context.read<NearCanchas>().setDefintive([]);
  context.read<LoggedUser>().setData(null);
  context.read<IsAdmin>().setIsAdmin(false);
}
