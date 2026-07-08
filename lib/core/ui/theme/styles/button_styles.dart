import 'package:flutter/material.dart';

import 'colors_app.dart';
import 'text_styles.dart';

class ButtonStyles {
  static ButtonStyles? _instance;
  ButtonStyles._();
  static ButtonStyles get instance {
    _instance ??= ButtonStyles._();
    return _instance!;
  }

  ButtonStyle get primary {
    return ElevatedButton.styleFrom(
      backgroundColor: ColorsApp.instance.primary,
      textStyle: TextStyles.instance.textButtonLabel,
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
    );
  }

  ButtonStyle get secondary {
    return primary.copyWith(backgroundColor: WidgetStateProperty.all<Color>(ColorsApp.instance.secondary));
  }

  ButtonStyle get text {
    return TextButton.styleFrom(
      textStyle: TextStyles.instance.textSecondaryButtonLabel,
      foregroundColor: ColorsApp.instance.primary,
    );
  }
}

extension ButtonStylesExtension on BuildContext {
  ButtonStyles get appStyles => ButtonStyles.instance;
}
