import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:royalcruiser/utils/helpers/get_version.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  static const MethodChannel _channel = MethodChannel('unique_identifier');

  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static String generateRandom6DigitOTP() {
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var randomizer = Random();
    var rNum = min + randomizer.nextInt(max - min);
    return rNum.toString();
  }

  static bool checkIsEmptyOrNullForStringAndInt(Object? object) {
    if (object == null) {
      return true;
    } else if (object.toString().isEmpty) {
      return true;
    }
    return false;
  }

  static void todayDate() {
    var now = DateTime.now();
    // var formatter = new DateFormat('dd-MM-yyyy');
    var formatter1=DateFormat('yyyy-MM-dd');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter1.format(now);
  }

  static String getMonthNameFromDate(DateTime now) {
    var formatter1 = DateFormat('MMM');
    String formattedDate = formatter1.format(now);
    return formattedDate;
  }

  static Future<String?> getAndroidOrIosOrDeviceId() async {
    return await PlatformDeviceId.getDeviceId;
  }

  static Future<String?> getDeviceModel() async {
    return await PlatformDeviceId.getdevicemodel;
  }

  static Future<String?> getDeviceName() async {
  return await PlatformDeviceId.getdevicename;
  }

  static Future<String?> getDeviceOsVersion() async {
    return await PlatformDeviceId.getdeviceosversion;
  }

  static Future<String?> getDeviceProduct() async {
    return await PlatformDeviceId.getdeviceproduct;
  }

  static Future<String?> getAppVersionCode() async {
    String appVersionCode = await GetVersion.projectCode;
    return appVersionCode;
  }

  static Future<String?> getAppVersionName() async {
    String appVersionCode = await GetVersion.projectVersion;
    return appVersionCode;
  }

  static Future<void> openMap(String latitude, String longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    print(googleUrl);

    if (!await launchUrl(
        Uri.parse(googleUrl
          // "https://maps.app.goo.gl/eqeuwmK3EkeugxvCA?g_st=iw"
          //    'https://www.google.com/maps/search/?api=1&query=22.5624881,88.3503305',
        ),
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw Exception(
          'Could not launch ${googleUrl}=="https://maps.app.goo.gl/eqeuwmK3EkeugxvCA?g_st=iw');
    }
  }

}
