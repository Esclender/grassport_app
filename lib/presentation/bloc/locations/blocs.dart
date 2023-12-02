import 'package:bloc/bloc.dart';
import 'package:grassport_app/api/api_client.dart';

class SelectLocation extends Cubit<int> {
  SelectLocation()
      : super(0); //0 is equal to history and 1 equal to serch places

  void toggleState(int event) {
    emit(event);
  }

  getRegistros({address = ''}) async {
    if (state == 0) {
      Map location = await ApiClient().getMyHistory();

      return location['historial'];
    }

    Map location = await ApiClient().searchByAddress(search: address);

    return location['response']; //change by the search places
  }
}
