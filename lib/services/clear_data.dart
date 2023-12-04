import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/google_map_markers/bloc.dart';

void clearDataLoggedUser(BuildContext context) {
  context.read<GoogleMapMarkers>().clear();
  context.read<CanchasByInout>().setCanchasByInput([]);
}
