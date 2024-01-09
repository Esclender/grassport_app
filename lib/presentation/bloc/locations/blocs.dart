import 'package:bloc/bloc.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/lis_item_model.dart';

ApiClient myClient = ApiClient();

class SelectLocation extends Cubit<int> {
  SelectLocation()
      : super(0); //0 is equal to history and 1 equal to serch places

  void toggleState(int event) {
    emit(event);
  }

  getRegistros({address = ''}) async {
    if (state == 0) {
      List<LocationTagModel> location = await myClient.getMyHistory();

      return location;
    }

    Map location = await myClient.searchByAddress(search: address);
    return location['response']; //change by the search places
  }
}

class IsGpsEnabled extends Cubit<bool> {
  IsGpsEnabled() : super(false);

  void setGpsPermissions(bool isEnabled) {
    emit(isEnabled);
  }
}
