import 'dart:ui';
import 'package:grassport_app/presentation/styles/colors.dart';

class BarData {
  const BarData({
    required this.color,
    required this.value,
    required this.name,
    required this.imageURL,
  });
  final Color color;
  final double value;
  final String name;
  final String imageURL;

  static transformBodyArray(body) {
    List<BarData> barsList = [];

    for (Map bar in body) {
      BarData barInfo = BarData(
        color: c5,
        value: double.parse(bar['conteo_ingresos'].toString()),
        name: bar['nombre'],
        imageURL: bar['imageURL'],
      );
      barsList.add(barInfo);
    }

    return barsList;
  }
}
