import 'package:flutter_bloc/flutter_bloc.dart';

class PostingCanchaData extends Cubit<Map> {
  PostingCanchaData() : super({});

  void setStep1({
    canchaName,
    canchaAddress,
    canchaDescription,
  }) {
    emit({
      "nombre": canchaName,
      "direccion": canchaAddress,
      "descripcion": canchaDescription,
    });
  }
}
