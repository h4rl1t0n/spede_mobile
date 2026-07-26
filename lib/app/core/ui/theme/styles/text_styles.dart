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
    return const TextStyle(fontWeight: FontWeight.w300, fontFamily: fontFamily);
  }

  TextStyle get textRegular {
    return const TextStyle(fontWeight: FontWeight.w400, fontFamily: fontFamily);
  }

  TextStyle get textMedium {
    return const TextStyle(fontWeight: FontWeight.w500, fontFamily: fontFamily, fontSize: 16, color: Colors.black);
  }

  TextStyle get textSemiBold {
    return const TextStyle(fontWeight: FontWeight.w600, fontFamily: fontFamily);
  }

  TextStyle get textBold {
    return const TextStyle(fontWeight: FontWeight.w700, fontFamily: fontFamily);
  }

  TextStyle get textExtraBold {
    return const TextStyle(fontWeight: FontWeight.w800, fontFamily: fontFamily);
  }

  TextStyle get textButtonLabel {
    return textSemiBold.copyWith(fontSize: 16, color: Colors.white);
  }

  TextStyle get textPrimaryButtonLabel {
    return textSemiBold.copyWith(fontSize: 16, color: ColorsApp.instance.primary);
  }

  TextStyle get textSecondaryButtonLabel {
    return textSemiBold.copyWith(fontSize: 16, color: ColorsApp.instance.secondary);
  }

  TextStyle get textTitleItemList {
    return textSemiBold.copyWith(fontSize: 16, color: ColorsApp.instance.black);
  }

  TextStyle get textSubTitleItemList {
    return textRegular.copyWith(fontSize: 14, color: Colors.black54);
  }

  TextStyle get textTitle {
    return textBold.copyWith(fontSize: 24, color: ColorsApp.instance.black);
  }

  TextStyle get textHeadline {
    return textExtraBold.copyWith(fontSize: 32, color: ColorsApp.instance.black);
  }

  TextStyle get textCaption {
    return textRegular.copyWith(fontSize: 12, color: Colors.black54);
  }
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles {
    return TextStyles.instance;
  }
}
