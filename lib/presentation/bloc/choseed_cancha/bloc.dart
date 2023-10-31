import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/models/cancha_info.dart';

var nearCanchas = [
  CanchaInfo(
    nombre: "Cancha 2",
    direccion: "Av Mexico, Miraflores",
    rating: 3,
    owner: "Esclender Lugo",
    horario: {"start": "10:00", "end": "19:00"},
    img:
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg",
    price: 100.10,
  ),
  CanchaInfo(
    nombre: "Cancha 2",
    direccion: "Av Mexico, Miraflores",
    rating: 3,
    owner: "Esclender Lugo",
    horario: {"start": "10:00", "end": "19:00"},
    img:
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg",
    price: 100.10,
  ),
  CanchaInfo(
    nombre: "Cancha 2",
    direccion: "Av Mexico, Miraflores",
    rating: 3,
    owner: "Esclender Lugo",
    horario: {"start": "10:00", "end": "19:00"},
    img:
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg",
    price: 100.10,
  ),
  CanchaInfo(
    nombre: "Cancha 2",
    direccion: "Av Mexico, Miraflores",
    rating: 3,
    owner: "Esclender Lugo",
    horario: {"start": "10:00", "end": "19:00"},
    img:
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg",
    price: 100.10,
  ),
  CanchaInfo(
    nombre: "Cancha 2",
    direccion: "Av Mexico, Miraflores",
    rating: 3,
    owner: "Esclender Lugo",
    horario: {"start": "10:00", "end": "19:00"},
    img:
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg",
    price: 100.10,
  )
];

class ChoseedCancha extends Cubit<int> {
  ChoseedCancha() : super(0);

  CanchaInfo getCanchaSpec() {
    return nearCanchas[state];
  }

  void changeInd(ind) {
    emit(ind);
  }
}
