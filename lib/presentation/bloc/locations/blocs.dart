import 'package:bloc/bloc.dart';
import 'package:grassport_app/api/api_client.dart';

const historyLocations = [
  {
    "leading": "place",
    "street": "Venezuela, Ate 15494, Peru",
    "locality": "Venezuela",
    "location": {"lat": -12.0433554, "lng": -76.9152919}
  },
  {
    "leading": "place",
    "street": "Venezuela, Ate 15494, Peru",
    "locality": "Venezuela",
    "location": {"lat": -12.0433554, "lng": -76.9152919}
  },
  {
    "leading": "place",
    "street": "Venezuela, Ate 15494, Peru",
    "locality": "Venezuela",
    "location": {"lat": -12.0433554, "lng": -76.9152919}
  },
  {
    "leading": "place",
    "street": "Venezuela, Ate 15494, Peru",
    "locality": "Venezuela",
    "location": {"lat": -12.0433554, "lng": -76.9152919}
  },
];

class SelectLocation extends Cubit<int> {
  SelectLocation()
      : super(0); //0 is equal to history and 1 equal to serch places

  void toggleState(int event) {
    emit(event);
  }

  getRegistros({address = ''}) async {
    if (state == 0) {
      return historyLocations;
    }
    Map location = await ApiClient().searchByAddress(search: address);

    return location['response']; //change by the search places
  }
}
