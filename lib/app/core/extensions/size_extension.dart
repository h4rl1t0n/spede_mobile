import 'package:flutter/material.dart';

import 'orientation_extensions.dart';

extension SizeExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double percentWidth(double percent) => screenWidth * percent;
  double percentHeight(double percent) => screenHeight * percent;

  double get widthDialog {
    if (isPortrait) {
      if (screenWidth > 600) return percentWidth(0.6);
      return screenWidth;
    }
    return percentWidth(0.5);
  }
}
