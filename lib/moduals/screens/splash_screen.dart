import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/preferences_costances.dart';
import 'package:royalcruiser/model/source_city_model.dart';
import 'package:royalcruiser/moduals/screens/dashboard_screen.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/moduals/screens/update_screen.dart';
import 'package:royalcruiser/moduals/screens/welcome_screen.dart';
import 'package:royalcruiser/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:royalcruiser/utils/sp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

class ApplicationSplashScreen extends StatefulWidget {
  const ApplicationSplashScreen({Key? key}) : super(key: key);

  @override
  State<ApplicationSplashScreen> createState() => _ApplicationSplashScreenState();
}

class _ApplicationSplashScreenState extends State<ApplicationSplashScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences? _sharedPreferences;
  String? usertId;
  String userName = '';
  String usertEmail = '';
  String usertPhone = '';
  String userPassword = '';
  List<ITSSources> _selectSourceCityList = [];

  @override
  void initState() {
    _prefs.then((SharedPreferences sharedPreferences) {
      _sharedPreferences = sharedPreferences;
      storedeviceinfo().then((value) {
        usertId = _sharedPreferences!.getString(Preferences.CUST_ID) ?? "0";
        userName = _sharedPreferences!.getString(Preferences.CUST_NAME) ?? '';
        usertEmail = _sharedPreferences!.getString(Preferences.CUST_EMAIL) ?? '';
        usertPhone = _sharedPreferences!.getString(Preferences.CUST_PHONE) ?? '';
        userPassword = _sharedPreferences!.getString(Preferences.CUST_PASSWORD) ?? '';
      }).then((value) {
        NavigatorConstants.USER_ID = usertId!;
        NavigatorConstants.USER_NAME = userName;
        NavigatorConstants.USER_EMAIL = usertEmail;
        NavigatorConstants.USER_PHONE = usertPhone;
        NavigatorConstants.USER_PASSWORD = userPassword;
      }).then((value) {
        applicationExtraSettingsApiCall();
        getBannerApiCall(context);
        getSourceB2Cv2ApiCall();
      }).then((value) => versionCheckApiCall());
    });
    super.initState();
  }

  void getBannerApiCall(BuildContext context) {
    ApiImplementer.applicationSplashScreenListApiImplementer(currentDate: DateFormat('yyyy-MM-dd').format(DateTime.now()), height: "1080", width: "2200").then((XmlDocument document) {
      List<XmlElement> data = document.findAllElements('SplashScreenList').toList();

      List<String> _popup = [];
      NavigatorConstants.POP_UP_BANNER_BOOL = '0';

      for (int i = 0; i < data.length; i++) {
        if (data[i].getElement('Type')!.text.compareTo("1") == 0) {
          _popup.add(data[i].getElement('Details')!.text.trim().toString());
        }
      }

      NavigatorConstants.POP_UP_BANNER = json.encode(_popup as List<String>);
    }).catchError((onError) {
      Navigator.of(context).pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
      print('  onError:::getSourceB2Cv2ApiCall===>$onError');
    });
  }

  void getSourceB2Cv2ApiCall() {
    ApiImplementer.getSourceB2Cv2ApiImplementer().then((XmlDocument document) {
      bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        List<XmlElement> element = document.findAllElements('ITSSources').toList();
        for (int i = 0; i < element.length; i++) {
          ITSSources itsSources = ITSSources(
            CM_CityID: element[i].getElement('CM_CityID')!.text,
            CM_CityName: element[i].getElement('CM_CityName')!.text,
          );
          _selectSourceCityList.add(itsSources);
        }
        _sharedPreferences!.setString(NavigatorConstants.SOURCE_CITY, json.encode(_selectSourceCityList as List<ITSSources>));
      }
    }).catchError((onError) {
      Navigator.of(context).pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
      print('  onError:::getSourceB2Cv2ApiCall===>$onError');
    });
  }

  void versionCheckApiCall() {
    ApiImplementer.applicationVersionCheckApiImplementer().then((XmlDocument document) async {
      XmlElement xmlElement = document.findAllElements('ApplicationVersion').first;
      String IsSurcharge = xmlElement.getElement('IsSurcharge')!.text.toString();
      NavigatorConstants.IS_SEARCH_CHARGE = IsSurcharge;
      print('================${NavigatorConstants.IS_SEARCH_CHARGE} ');

      if (xmlElement != null) {
        if ((int.parse(NavigatorConstants.APPLICATION_VERSION_CODE) < int.parse(xmlElement.getElement('VersionCode')!.text)) && xmlElement.getElement('AppDownloadType')!.text == "1") {
          Navigator.of(context).pushReplacementNamed(UpdateApplicationScreen.routeName, arguments: {
            NavigatorConstants.APP_UPDATE_TYPE: CommonConstants.OPTIONAL_UPDATE,
            NavigatorConstants.IS_FORCE_UPDATE: false,
          });
        } else if ((int.parse(NavigatorConstants.APPLICATION_VERSION_CODE) < int.parse(xmlElement.getElement('VersionCode')!.text)) && xmlElement.getElement('AppDownloadType')!.text == "2") {
          Navigator.of(context).pushReplacementNamed(UpdateApplicationScreen.routeName, arguments: {
            NavigatorConstants.APP_UPDATE_TYPE: CommonConstants.FORCE_UPDATE,
            NavigatorConstants.IS_FORCE_UPDATE: true,
          });
        } else {
          _sharedPreferences!.setString(Preferences.UPDATE_APP_VERSION_CODE, xmlElement.getElement('VersionCode')!.text.toString());
          // Navigator.of(context)
          //     .pushReplacementNamed(DashboardAppScreen.routeName);

          print('Check login :- ${NavigatorConstants.USER_NAME}');

          bool isUserFirstTime = await Sp().getIsUserFirstTime();
          if (isUserFirstTime) {
            Get.offAll(() => WelcomeScreen());
          } else {
            Get.offAllNamed(DashboardAppScreen.routeName);
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
      print('  onError:::versionCheckApiCall===>$onError');
    });
  }

  void applicationExtraSettingsApiCall() {
    ApiImplementer.getApplicationExtraSettingsApiImplementer().then((XmlDocument document) {
      XmlElement xmlElement = document.findAllElements('IB2C_SeatLayoutColor').first;
      String AVAILABLE_SEAT = xmlElement.getElement('Available')!.text.toString();
      String BOOKED_SEAT = xmlElement.getElement('Booked')!.text.toString();
      String LADIES_SEAT = xmlElement.getElement('Ladies')!.text.toString();
      String SELECTED_SEAT = xmlElement.getElement('Selected')!.text.toString();
      NavigatorConstants.AVAILABLE_SEAT_COLOR = AVAILABLE_SEAT;
      NavigatorConstants.BOOKED_SEAT_COLOR = BOOKED_SEAT;
      NavigatorConstants.LADIES_SEAT_COLOR = LADIES_SEAT;
      NavigatorConstants.SELECTED_SEAT_COLOR = SELECTED_SEAT;
    }).catchError((onError) {
      Navigator.of(context).pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
      print(':::: onError :: getApplicationExtraSettingsApiImplementer ====> $onError');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Image(
            image: AssetImage('assets/images/splash_logo.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Future<void> storedeviceinfo() async {
    String? versionname = await Helper.getAppVersionName();
    String? versioncode = await Helper.getAppVersionCode();
    String? androidoriosid = await Helper.getAndroidOrIosOrDeviceId();
    String? deviceosversion = await Helper.getDeviceOsVersion();

    NavigatorConstants.APPLICATION_VERSION_NAME = versionname!;
    NavigatorConstants.APPLICATION_VERSION_CODE = versioncode!;
    NavigatorConstants.DEVICE_ID = androidoriosid!;
    NavigatorConstants.DEVICE_OS_VERSION = deviceosversion!;
  }
}
