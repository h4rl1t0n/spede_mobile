import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_schemes.dart';
import 'styles/button_styles.dart';
import 'styles/text_styles.dart';

class ThemeConfig {
  ThemeConfig._();

  static ThemeData _buildTheme({required Brightness brightness, required ColorScheme colorScheme}) {
    return ThemeData(
      fontFamily: 'Cabin',
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      iconTheme: IconThemeData(color: colorScheme.primary),

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: colorScheme.surface),
        titleTextStyle: TextStyle(
          fontFamily: 'Cabin',
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: colorScheme.surface,
        ),
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TextStyle(fontFamily: 'Cabin', fontSize: 14, color: colorScheme.onSurface),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(colorScheme.surface),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          elevation: const WidgetStatePropertyAll(4),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        ),
      ),

      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(TextStyle(fontFamily: 'Cabin', fontSize: 14, color: colorScheme.onSurface)),
          backgroundColor: WidgetStatePropertyAll(colorScheme.surface),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          elevation: const WidgetStatePropertyAll(4),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyles.instance.primary),
      textButtonTheme: TextButtonThemeData(style: ButtonStyles.instance.text),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: .50)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1.25),
        ),
        labelStyle: TextStyles.instance.textRegular.copyWith(color: colorScheme.onSurfaceVariant, fontFamily: 'Cabin'),
        hintStyle: TextStyles.instance.textRegular.copyWith(
          color: colorScheme.onSurfaceVariant.withValues(alpha: .7),
          fontFamily: 'Cabin',
          fontWeight: .w500,
        ),
        errorStyle: TextStyles.instance.textRegular.copyWith(color: colorScheme.error, fontFamily: 'Cabin'),
      ),

      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontFamily: 'Cabin',
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: colorScheme.onSurface,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Cabin',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(fontFamily: 'Cabin', fontSize: 16, color: colorScheme.onSurface),
        bodyMedium: TextStyle(fontFamily: 'Cabin', fontSize: 14, color: colorScheme.onSurface),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: colorScheme.primary.withValues(alpha: .12),
        elevation: 0,
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            fontFamily: 'Cabin',
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected) ? FontWeight.w700 : FontWeight.w500,
            color: states.contains(WidgetState.selected) ? colorScheme.primary : colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            size: 24,
            color: states.contains(WidgetState.selected) ? colorScheme.primary : colorScheme.onSurfaceVariant,
          );
        }),
      ),

      dialogTheme: DialogThemeData(
        insetPadding: EdgeInsets.all(15),
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: TextStyles.instance.textTitle.copyWith(fontSize: 22, color: colorScheme.onSurface),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      ),

      expansionTileTheme: ExpansionTileThemeData(
        iconColor: colorScheme.primary,
        collapsedIconColor: colorScheme.onSurfaceVariant,
        textColor: colorScheme.primary,
        collapsedTextColor: colorScheme.onSurface,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: .2),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: .5), width: 0.5),
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      ),

      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.primary,
        textColor: colorScheme.onSurface,
        selectedColor: colorScheme.primary,
        selectedTileColor: colorScheme.primary.withValues(alpha: .12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        titleTextStyle: TextStyle(
          fontFamily: 'Cabin',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        subtitleTextStyle: TextStyle(
          fontFamily: 'Cabin',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.surfaceContainerHighest,
      ),

      cardTheme: CardThemeData(
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: .05),
        surfaceTintColor: Colors.transparent,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 2,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),

      dividerTheme: DividerThemeData(color: colorScheme.outlineVariant.withValues(alpha: .5), thickness: .5),

      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primary.withValues(alpha: .12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        labelStyle: TextStyle(fontFamily: 'Cabin', color: colorScheme.onSurface),
      ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionColor: colorScheme.primary.withValues(alpha: .25),
        selectionHandleColor: colorScheme.primary,
      ),

      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        todayBorder: BorderSide(color: colorScheme.secondary, width: 2),
        todayForegroundColor: WidgetStatePropertyAll(colorScheme.secondary),
        todayBackgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        dayShape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),

      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static final lightTheme = _buildTheme(brightness: Brightness.light, colorScheme: lightColorScheme);

  static final darkTheme = _buildTheme(brightness: Brightness.dark, colorScheme: darkColorScheme);
}
