import 'package:flutter/widgets.dart';

class ScreenUtil {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
