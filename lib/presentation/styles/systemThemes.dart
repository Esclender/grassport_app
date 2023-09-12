import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/colors.dart';

class SystemModifiers {
  static SystemUiOverlayStyle overlayLigth = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: c1,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static SystemUiOverlayStyle overlayDark = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: c8,
    systemNavigationBarIconBrightness: Brightness.light,
  );
}
