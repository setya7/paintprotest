import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_constants.dart';

class Helper {
  /// Get svg picture path
  static String getSvgPath(String name) {
    return "$svgPath$name";
  }

  /// Get image picture path
  static String getImagePath(String name) {
    return "$imagePath$name";
  }

  /// Get vertical space
  static double getVerticalSpace() {
    return 10.h;
  }

  /// Get horizontal space
  static double getHorizontalSpace() {
    return 10.w;
  }

  /// Get Dio Header
  static Map<String, dynamic> getHeaders() {
    return {
      'operation-system' : 'android'
    }..removeWhere((key, value) => value == null);
  }

  // static bool isDarkTheme() {
  //   return sl<AppSharedPrefs>().getIsDarkTheme();
  // }
}
