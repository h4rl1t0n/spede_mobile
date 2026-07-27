import 'package:flutter/material.dart';

import 'colors_app.dart';

class TextStyles {
  static TextStyles? _instance;
  static const String fontFamily = 'Cabin';

  TextStyles._();

  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  TextStyle get textLight {
    return const TextStyle(fontWeight: FontWeight.w300, fontFamily: fontFamily, height: 1.3);
  }

  TextStyle get textRegular {
    return const TextStyle(fontWeight: FontWeight.w400, fontFamily: fontFamily, height: 1.4);
  }

  TextStyle get textMedium {
    return const TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
      fontSize: 16,
      color: Colors.black,
      height: 1.5,
    );
  }

  TextStyle get textSemiBold {
    return const TextStyle(fontWeight: FontWeight.w600, fontFamily: fontFamily, height: 1.3);
  }

  TextStyle get textBold {
    return const TextStyle(fontWeight: FontWeight.w700, fontFamily: fontFamily, height: 1.2);
  }

  TextStyle get textExtraBold {
    return const TextStyle(fontWeight: FontWeight.w800, fontFamily: fontFamily, height: 1.1);
  }

  TextStyle get textButtonLabel {
    return textSemiBold.copyWith(fontSize: 16, color: Colors.white, letterSpacing: 0.3);
  }

  TextStyle get textPrimaryButtonLabel {
    return textSemiBold.copyWith(fontSize: 16, color: ColorsApp.instance.primary, letterSpacing: 0.3);
  }

  TextStyle get textSecondaryButtonLabel {
    return textSemiBold.copyWith(fontSize: 16, color: ColorsApp.instance.secondary, letterSpacing: 0.3);
  }

  TextStyle get textTitleItemList {
    return textSemiBold.copyWith(fontSize: 16, color: ColorsApp.instance.black, letterSpacing: -0.1);
  }

  TextStyle get textSubTitleItemList {
    return textRegular.copyWith(fontSize: 14, color: Colors.black54, letterSpacing: 0.1);
  }

  TextStyle get textTitle {
    return textBold.copyWith(fontSize: 24, color: ColorsApp.instance.black, letterSpacing: -0.3);
  }

  TextStyle get textHeadline {
    return textExtraBold.copyWith(fontSize: 32, color: ColorsApp.instance.black, letterSpacing: -0.5);
  }

  TextStyle get textCaption {
    return textRegular.copyWith(fontSize: 12, color: Colors.black54, letterSpacing: 0.2);
  }
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
