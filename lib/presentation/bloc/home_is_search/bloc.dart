import 'package:flutter_bloc/flutter_bloc.dart';

class IsSearch extends Cubit<bool> {
  IsSearch() : super(false);

  void toggleSearch(bol) {
    emit(bol);
  }
}
