// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/moduals/screens/about_us_screen.dart';
import 'package:royalcruiser/moduals/screens/avilable_route_screen.dart';
import 'package:royalcruiser/moduals/screens/boarding_dropping_point_screen.dart';
import 'package:royalcruiser/moduals/screens/booking_dashboard_screen.dart';
import 'package:royalcruiser/moduals/screens/cancellation_screen.dart';
import 'package:royalcruiser/moduals/screens/confirm_cancellation_screen.dart';
import 'package:royalcruiser/moduals/screens/contct_us_screen.dart';
import 'package:royalcruiser/moduals/screens/dashboard_screen.dart';
import 'package:royalcruiser/moduals/screens/feedback_screen.dart';
import 'package:royalcruiser/moduals/screens/forgot_password_screen.dart';
import 'package:royalcruiser/moduals/screens/from_city_screen.dart';
import 'package:royalcruiser/moduals/screens/gallery_photo_screen.dart';
import 'package:royalcruiser/moduals/screens/gallery_screen.dart';
import 'package:royalcruiser/moduals/screens/home_page_screen.dart';
import 'package:royalcruiser/moduals/screens/login_screen.dart';
import 'package:royalcruiser/moduals/screens/my_booking_screen.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/moduals/screens/passenger_info_screen.dart';
import 'package:royalcruiser/moduals/screens/payment_main_screen_v1.dart';
import 'package:royalcruiser/moduals/screens/payment_main_screen_v2.dart';
import 'package:royalcruiser/moduals/screens/pnr_enquiry_screen.dart';
import 'package:royalcruiser/moduals/screens/pnr_html_widget_screen.dart';
import 'package:royalcruiser/moduals/screens/registration_screen.dart';
import 'package:royalcruiser/moduals/screens/seat_arrangement_screen.dart';
import 'package:royalcruiser/moduals/screens/splash_screen.dart';
import 'package:royalcruiser/moduals/screens/terms_and_condition_screen.dart';
import 'package:royalcruiser/moduals/screens/to_city_screen.dart';
import 'package:royalcruiser/moduals/screens/update_screen.dart';
import 'package:royalcruiser/moduals/screens/verification_screen.dart';

import 'constants/common_constance.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    if (GetPlatform.isAndroid) {
      CommonConstants.STR_KEY = "b58355b594b8478bac8894cc6d32744032636264883275428303";
      CommonConstants.APP_NAME = "royalcruiser";
    } else if (GetPlatform.isIOS) {
      //TODO make changes
      CommonConstants.STR_KEY = "0709a5fd6d5143f58ca88a8f572b793244637509050727609232";
      CommonConstants.APP_NAME = "royalcruiserIOS";
    }
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        colorScheme: const ColorScheme.light(
          primary: CustomeColor.main_bg,
          primaryVariant: CustomeColor.main_bg,
          secondary: CustomeColor.sub_bg,
          // secondaryVariant: CustomColor.colorAccent,
          // background: CustomColor.colorCanvas,
          error: Colors.red,
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: CustomeColor.sub_bg,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      defaultTransition: Transition.leftToRight,
      initialRoute: '/',
      routes: {
        '/': (ctx) => const ApplicationSplashScreen(),
        UpdateApplicationScreen.routeName: (ctx) => UpdateApplicationScreen(),
        DashboardAppScreen.routeName: (ctx) => DashboardAppScreen(),
        HomePageFragmnet.routeName: (ctx) => const HomePageFragmnet(),
        FromCitySearchApplicationScreen.routeName: (ctx) => const FromCitySearchApplicationScreen(),
        ToCitySearchApplicationScreen.routeName: (ctx) => const ToCitySearchApplicationScreen(),
        MyBookingAppScreen.routeName: (ctx) => const MyBookingAppScreen(),
        MyBookingDashBoardScreen.routeName: (ctx) => const MyBookingDashBoardScreen(),
        CancellationAppScreen.routeName: (ctx) => const CancellationAppScreen(),
        ConfirmCancellationAppScreen.routeName: (ctx) => const ConfirmCancellationAppScreen(),
        GalleryAppScreen.routeName: (ctx) => const GalleryAppScreen(),
        FeedbackAppScreen.routeName: (ctx) => const FeedbackAppScreen(),
        AboutUsAppScreen.routeName: (ctx) => const AboutUsAppScreen(),
        ContactUsAppScreen.routeName: (ctx) => const ContactUsAppScreen(),
        AvailableRoutesAppScreen.routeName: (ctx) => const AvailableRoutesAppScreen(),
        SeatArrangementAppScreen.routeName: (ctx) => const SeatArrangementAppScreen(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        BoardingAndDroppingPointScreen.routeName: (ctx) => BoardingAndDroppingPointScreen(),
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
        ForgotPasswordScreen.routeName: (ctx) => const ForgotPasswordScreen(),
        VerificationScreen.routeName: (ctx) => const VerificationScreen(),
        PassengerInfoScreen.routeName: (ctx) => const PassengerInfoScreen(),
        PaymentMainScreenV1.routeName: (ctx) => const PaymentMainScreenV1(),
        PaymentMainScreenV2.routeName: (ctx) => const PaymentMainScreenV2(),
        GalleryPhotoScreen.routeName: (ctx) => const GalleryPhotoScreen(),
        TermsAndConditionScreen.routeName: (ctx) => const TermsAndConditionScreen(),
        PNREnquiryScreen.routeName: (ctx) => const PNREnquiryScreen(),
        PNRhtmlScreen.routeName: (ctx) => const PNRhtmlScreen(),
        NoInterNetOrErrorScreen.routeName: (ctx) => const NoInterNetOrErrorScreen(),
      },
    );
  }
}
