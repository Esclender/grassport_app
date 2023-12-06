import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';

List<CanchaInfo> searchLocations = [];

class SavedLocations extends Cubit<List<CanchaInfo>> {
  SavedLocations() : super([]);

  getRegistros() async {
    List<CanchaInfo> data = await ApiClient().getMyFavorites();

    emit([...data]);

    return data;
  }
}
