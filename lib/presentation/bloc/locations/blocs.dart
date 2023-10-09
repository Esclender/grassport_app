import 'package:bloc/bloc.dart';

const historyLocations = [
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "history",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
];

const searchLocations = [
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
  {
    "leading": "place",
    "department": "Los olivos",
    "location": "Los olivos, independencia"
  },
];

class SelectLocation extends Cubit<int> {
  SelectLocation()
      : super(0); //0 is equal to history and 1 equal to serch places

  void toggleState(int event) {
    emit(event);
  }

  List getRegistros() {
    if (state == 0) {
      return historyLocations;
    }

    return searchLocations; //change by the search places
  }
}
