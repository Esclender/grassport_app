import 'package:android_intent_plus/android_intent.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io' show Platform;

void openLocationSetting() async {
  if (Platform.isAndroid) {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_application_details_settings',
      data:
          'package:com.example.grassport_app', // replace com.example.app with your applicationId
    );
    await intent.launch();
    var geolocationStatus = await Geolocator.checkPermission();
    print(
        "*****************************************************************************************ACCEPTED?");
    print(geolocationStatus);
  }
}
