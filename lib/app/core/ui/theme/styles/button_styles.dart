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
      // minimumSize: const Size.fromHeight(45),
      backgroundColor: ColorsApp.instance.primary,
      textStyle: TextStyles.instance.textMedium,
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  ButtonStyle get secondary {
    return primary.copyWith(backgroundColor: WidgetStateProperty.all<Color>(ColorsApp.instance.secondary));
  }

  ButtonStyle get text {
    return TextButton.styleFrom(foregroundColor: ColorsApp.instance.primary);
  }
}

extension ButtonStylesExtension on BuildContext {
  ButtonStyles get appStyles => ButtonStyles.instance;
}
