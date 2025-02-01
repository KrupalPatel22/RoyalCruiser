import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/moduals/screens/booking_dashboard_screen.dart';
import 'package:royalcruiser/moduals/screens/login_screen.dart';
import 'package:royalcruiser/moduals/screens/welcome_screen.dart';

class MyBookingAppScreen extends StatefulWidget {
  static const routeName = '/my_booking_frg';

  const MyBookingAppScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingAppScreen> createState() => _MyBookingAppScreenState();
}

class _MyBookingAppScreenState extends State<MyBookingAppScreen> {
  RxBool _isLoading = false.obs;
  String? UserId;
  String? UserEmail;
  String? UserPassword;

  @override
  void initState() {
    getData().then((value) {
      if (UserId!.compareTo("0")==0) {
        _isLoading.value = false;
      } else {
        _isLoading.value = true;
      }
    });
    super.initState();
  }

  Future<void> getData() async {


    UserId = NavigatorConstants.USER_ID;
    UserPassword = NavigatorConstants.USER_PASSWORD;
    UserEmail = NavigatorConstants.USER_EMAIL;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => !_isLoading.value
            ? WelcomeScreen()
              // LoginScreen(appTitle: 'My Booking',)
            : MyBookingDashBoardScreen()
      ),
    );
  }
}