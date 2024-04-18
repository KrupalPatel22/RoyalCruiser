import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/moduals/screens/about_us_screen.dart';
import 'package:royalcruiser/moduals/screens/cancellation_screen.dart';
import 'package:royalcruiser/moduals/screens/contact_us_screen.dart';
import 'package:royalcruiser/moduals/screens/gallery_screen.dart';
import 'package:royalcruiser/moduals/screens/home_page_screen.dart';
import 'package:royalcruiser/moduals/screens/login_screen.dart';
import 'package:royalcruiser/moduals/screens/more_section_screen.dart';
import 'package:royalcruiser/moduals/screens/my_booking_screen.dart';
import 'package:royalcruiser/moduals/screens/terms_and_condition_screen.dart';

class DashboardAppScreen extends StatefulWidget {
  static const routeName = '/Dashboard-screen';

  int defaultScreen;

  DashboardAppScreen({this.defaultScreen = 4});

  @override
  _DashboardAppScreenState createState() => _DashboardAppScreenState();
}

class _DashboardAppScreenState extends State<DashboardAppScreen> {
  List<IconData> iconList = [
    Icons.airplane_ticket_outlined,
    Icons.contact_phone_outlined,
    Icons.cancel_presentation_sharp,
    Icons.more_vert_sharp,
  ];

  int _bottomNavIndex = 4;

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = widget.defaultScreen;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: CustomeColor.main_bg,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/bannerbg.png"),
                  opacity: 80.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _getDrawerItemWidget(_bottomNavIndex)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomeColor.main_bg,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Image(
              image: AssetImage(
                'assets/images/ic_launcher.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          elevation: 2.0,
          onPressed: () {
            setState(() {
              _bottomNavIndex = 4;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          height: 65,
          backgroundColor: CustomeColor.main_bg,
          splashColor: Colors.red,
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 20,
          rightCornerRadius: 20,
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
      ),
    );
  }

  Widget _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MyBookingAppScreen();
      case 1:
        return new ContactUsScreen();
      case 2:
        return new CancellationAppScreen();
      case 3:
        return new MoreSectionScreen();
      case 4:
        return new HomePageFragmnet();

      default:
        return new Center(
          child: Text("Error"),
        );

    }
  }
}
