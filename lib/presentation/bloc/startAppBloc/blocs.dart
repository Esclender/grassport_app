import 'package:bloc/bloc.dart';

List<Map<String, String>> swipersInfo = [
  {
    "image": "assets/images/preview-image1.png",
    "title": "¡Bienvenido a nuestra app!",
    "description":
        "Estamos emocionados de tenerte aquí y ayudarte a encontrar las canchas de fútbol más cercanas disponibles para alquilar."
  },
  {
    "image": "assets/images/preview-image2.png",
    "title": "¡Encuentra!",
    "description":
        "Ya sea que estés organizando un partido con amigos o simplemente quieras disfrutar de una tarde de fútbol, estamos aquí para simplificar tu búsqueda y hacer que encuentres la cancha perfecta en un abrir y cerrar de ojos."
  },
  {
    "image": "assets/images/preview-image3.png",
    "title": "¡Califica y Comenta!",
    "description":
        "Califica y comenta sobre tu experiencia en cada una de ellas. Creemos que la retroalimentación de los usuarios es fundamental para ayudar a otros amantes del fútbol a tomar decisiones informadas y encontrar las canchas que se adapten a sus necesidades."
  }
];

class NextSwipers extends Cubit<int> {
  NextSwipers() : super(0);

  void incrementIndex() {
    if (state < 2) {
      emit(state + 1);
    }
  }

  Map<String, String> getSwipperInfo() {
    return swipersInfo[state];
  }
}
