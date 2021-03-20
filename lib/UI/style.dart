
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'assetColor.dart';

class style{
  static TextStyle myTextStyle(BuildContext context, double font) {
    return TextStyle(
      letterSpacing: 2,
      fontSize: font,
      fontWeight: FontWeight.bold,
      fontFamily: 'Recursive',
      color: UI.gray_white,
    );
  }
}