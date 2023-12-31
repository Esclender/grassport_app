import 'package:flutter/material.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/screens/StartingApp/firebase_init.dart';
import 'package:grassport_app/presentation/screens/StartingApp/location_agree.dart';
//import 'package:grassport_app/presentation/screens/StartingApp/login.dart';
import 'package:grassport_app/presentation/screens/StartingApp/login_app.dart';
import 'package:grassport_app/presentation/screens/StartingApp/previews.dart';
import 'package:grassport_app/presentation/screens/StartingApp/register_view.dart';
import 'package:grassport_app/presentation/screens/StartingApp/select_current_location.dart';
import 'package:grassport_app/presentation/screens/StartingApp/start.dart';
import 'package:grassport_app/presentation/screens/StartingApp/use_gps_location.dart';
import 'package:grassport_app/presentation/screens/cancha_details/cancha_details_view.dart';
import 'package:grassport_app/presentation/screens/cancha_details/comment_replies.dart';
import 'package:grassport_app/presentation/screens/chargeScreens/main_charge.dart';
import 'package:grassport_app/presentation/screens/home_app/admin_views/admin_home.dart';
import 'package:grassport_app/presentation/screens/home_app/favorite_view.dart';
import 'package:grassport_app/presentation/screens/home_app/home_view.dart';
import 'package:grassport_app/presentation/screens/home_app/notifications_view.dart';
import 'package:grassport_app/presentation/screens/home_app/profile_settings_views/modify_profile.dart';
import 'package:grassport_app/presentation/screens/home_app/profile_settings_views/report_problem.dart';
import 'package:grassport_app/presentation/screens/home_app/profile_settings_views/terms_conditions.dart';
import 'package:grassport_app/presentation/screens/home_app/report_detailes_view.dart';
import 'package:grassport_app/presentation/screens/myPlacesHome/card_details/myplace_canchas_details.dart';
import 'package:grassport_app/presentation/screens/myPlacesHome/welcome.dart';
import 'package:grassport_app/presentation/styles/side_to_side_transition.dart';

const String routeStartApp = '/start';
const String routeCharge = '/charge';
const String routePreviews = '/start/previews';
const String routeLogin = '/start/login';
const String routeRegister = '/start/register';
const String routeToAdminPanel = '/home/admin/panel';
const String routeAgreementLocation = '/agreementLocation';
const String routeSelectLocation = '/agreementLocation/selectCurrentLocation';
const String routeGpsLocation = '/agreementLocation/gpsLocation';
const String routeHomeApp = '/home';
const String routeMyPlaces = '/myPlaces';
const String routeMyPlacesCanchaDetails = '/myPlaces/canchaDetails';
const String routeCanchaDetails = '/home/cancha_details';

const String routeCanchaReplies = '/home/cancha_details/comment';
const String routeReportDetailed = '/home/report_detailed';

const String routeFavView = '/home/favorites';
const String routeNotifView = '/home/notifications';
const String routeEditProfile = '/home/profile/edit';
const String routeReportProblem = '/home/report';
const String routeTermsConditions = '/home/terms';
const String routeFirebase = '/firebase_init';

class MyRouters {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/start":
        return SideToSideTransition(child: const StartView());
      case "/charge":
        return SideToSideTransition(child: const EffectIntro());
      case "/start/previews":
        return SideToSideTransition(child: const Previews());
      case "/start/login":
        return FadeInTransition(child: const LoginScreen());
      case "/start/register":
        return SideToSideTransition(child: const RegistrationScreen());
      case "/agreementLocation":
        return FadeInTransition(child: const AgreementLocation());
      case "/agreementLocation/gpsLocation":
        return SideToSideTransition(child: const CurrentLocationByGps());
      case "/agreementLocation/selectCurrentLocation":
        return SideToSideTransition(child: const SelectCurrentLocation());
      case "/myPlaces":
        return FadeInTransition(child: const MyPlaceWelcomeScreen());
      case "/myPlaces/canchaDetails":
        CanchaInfo data = (settings.arguments as CanchaInfo);

        return SideToSideTransition(
          child: MyPlaceCanchasDetail(
            data: data,
          ),
        );
      case "/home":
        return FadeInTransition(child: const HomeApp());
      case "/home/admin/panel":
        return FadeInTransition(child: const AdminView());
      case "/home/favorites":
        return SideToSideTransition(child: const FavView());
      case "/home/notifications":
        return SideToSideTransition(child: const NotifView());
      case "/home/report":
        return SideToSideTransition(child: const ReportProblem());
      case "/home/report_detailed":
        return FadeInTransition(child: const ReportDetailedWidget());
      case "/home/terms":
        return SideToSideTransition(child: const TermsConditions());
      case "/home/cancha_details":
        CanchaInfo data = (settings.arguments as CanchaInfo);
        return SideToSideTransition(
          child: CanchaDetails(
            cancha: data,
          ),
        );
      case "/home/cancha_details/comment":
        //Comment data = (settings.arguments as Comment);
        return FadeInTransition(
          child: CommentRepliesDetailed(),
        );
      case "/home/profile/edit":
        return SideToSideTransition(child: const EditProfile());
      case "/firebase_init":
        return SideToSideTransition(child: const FirebaseInit());
      default:
        return MaterialPageRoute(builder: (context) => const StartView());
    }
  }
}
