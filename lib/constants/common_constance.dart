import 'package:get/get.dart';

class CommonConstants {
  static const int CONNECTION_TIME_OUT_IN_MILL_SEC = 180000;
  static const int RECEIVE_TIME_OUT_IN_MILL_SEC = 180000;

  static const String FONT_FAMILY_OPEN_SANS_REGULAR = "Open-Sans-Regular";
  static const String FONT_FAMILY_OPEN_SANS_BOLD = "Open-Sans-Bold";

  static const String FORCE_UPDATE = "ForceUpdate";
  static const String OPTIONAL_UPDATE = "OptionalUpdate";

  static String STR_KEY='STR_KEY';
  static String APP_NAME='APP_NAME';

  static double SCREEN_HEIGHT = Get.context!.height;
  static double SCREEN_WIDTH = Get.context!.width;
}
