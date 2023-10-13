import 'package:flutter_bloc/flutter_bloc.dart';

const nearCanchas = [
  {
    "nombre": "Cancha 002",
    "rating": 3,
    "direccion": "Av Mexio, Surco, Peru",
    "horario": {"start": "10:00", "end": "19:00"},
    "img":
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg"
  },
  {
    "nombre": "Cancha 002",
    "rating": 3,
    "direccion": "Av Mexio, Surco, Peru",
    "horario": {"start": "10:00", "end": "19:00"},
    "img":
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg"
  },
  {
    "nombre": "Cancha 002",
    "rating": 3,
    "direccion": "Av Mexio, Surco, Peru",
    "horario": {"start": "10:00", "end": "19:00"},
    "img":
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg"
  },
  {
    "nombre": "Cancha 002",
    "rating": 3,
    "direccion": "Av Mexio, Surco, Peru",
    "horario": {"start": "10:00", "end": "19:00"},
    "img":
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg"
  },
  {
    "nombre": "Cancha 002",
    "rating": 3,
    "direccion": "Av Mexio, Surco, Peru",
    "horario": {"start": "10:00", "end": "19:00"},
    "img":
        "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg"
  },
];

class NearCanchas extends Cubit<List> {
  NearCanchas() : super(nearCanchas);
}
