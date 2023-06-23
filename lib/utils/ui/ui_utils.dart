import 'package:royalcruiser/constants/common_constance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UiUtils {
  static GetBar successSnackBar({String title = 'Success', String? message}) {
    Get.log("[$title] $message");
    return GetBar(
      shouldIconPulse: true,
      messageText: Text(
        message!,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14.0,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.green.shade50,
      icon: Wrap(
        children: [
          Card(
            elevation: 2.0,
            margin: EdgeInsets.all(8.0),
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.check_circle, size: 32.0, color: Colors.white),
            ),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
      borderWidth: 1.0,
      borderRadius: 12.0,
      borderColor: Colors.green,
      duration: Duration(seconds: 2),
    );
  }

  static GetBar errorSnackBar({String title = 'Error', String? message}) {
    Get.log("[$title] $message", isError: true);
    return GetBar(
      messageText: Text(
        message!,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.red,
      icon: Wrap(
        children: [
          Card(
            elevation: 2.0,
            margin: EdgeInsets.all(8.0),
            color: Colors.red.shade500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.error_outline_outlined,
                  size: 25,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
      borderWidth: 1.0,
      borderRadius: 12.0,
      duration: Duration(milliseconds: 1200),
    );
  }

  static GetBar alertSnackBar(
      {String title = 'Alert', required String? message}) {
    Get.log("[$title] $message", isError: false);
    return GetBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline6!.merge(TextStyle(color: Colors.red))),
      messageText: Text(message!,
          style: Get.textTheme.caption!.merge(TextStyle(color: Colors.white,fontSize: 16))),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.red.shade300,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.warning_amber_rounded, size: 32, color: Colors.red),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 1),
    );
  }

  static GetBar notificationSnackBar(
      {String title = 'Notification', String? message}) {
    Get.log("[$title] $message", isError: false);
    return GetBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline6!
              .merge(TextStyle(color: Get.theme.hintColor))),
      messageText: Text(message!,
          style: Get.textTheme.caption!
              .merge(TextStyle(color: Get.theme.focusColor))),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon:
          Icon(Icons.notifications_none, size: 32, color: Get.theme.hintColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 2),
    );
  }
}
