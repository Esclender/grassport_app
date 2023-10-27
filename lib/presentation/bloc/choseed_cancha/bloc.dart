import 'package:flutter_bloc/flutter_bloc.dart';

const nearCanchas = [
  {
    "nombre": "Cancha 002",
    "rating": 3,
    "owner": "Esclender",
    "direccion": "Av Mexio, Surco, Peru",
    "price": 0,
    "horario": {"start": "10:00", "end": "19:00"},
    "img":
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg"
  },
  {
    "nombre": "Cancha 002",
    "rating": 5,
    "owner": "Esclender",
    "direccion": "Av Mexio, Surco, Peru",
    "price": 100.10,
    "horario": {"start": "10:00", "end": "19:00"},
    "img":
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg"
  },
  {
    "nombre": "Cancha 002",
    "rating": 3,
    "owner": "Esclender",
    "direccion": "Av Mexio, Surco, Peru",
    "price": 100.10,
    "horario": {"start": "10:00", "end": "19:00"},
    "img":
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg"
  },
  {
    "nombre": "Cancha 002",
    "rating": 3,
    "owner": "Esclender",
    "direccion": "Av Mexio, Surco, Peru",
    "price": 100.10,
    "horario": {"start": "10:00", "end": "19:00"},
    "img":
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg"
  },
  {
    "nombre": "Cancha 002",
    "rating": 4,
    "owner": "Esclender",
    "direccion": "Av Mexio, Surco, Peru",
    "price": 100.10,
    "horario": {"start": "10:00", "end": "19:00"},
    "img":
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg"
  },
];

class ChoseedCancha extends Cubit<int> {
  ChoseedCancha() : super(0);

  Map getCanchaSpec() {
    return nearCanchas[state];
  }

  void changeInd(ind) {
    emit(ind);
  }
}
