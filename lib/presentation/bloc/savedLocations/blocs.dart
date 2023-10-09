import 'package:flutter_bloc/flutter_bloc.dart';

const searchLocations = [
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
  // {
  //   "leading": "place",
  //   "department": "Los olivos",
  //   "location": "Los olivos, independencia"
  // },
];

class SavedLocations extends Cubit<List> {
  SavedLocations() : super(searchLocations);
}
