import 'package:app/presentation/common/utils/styles.dart';
import 'package:app/presentation/common/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppTheme {
  static PaintingEffect skeletonizerEffect(BuildContext context) =>
      const PulseEffect(
        from: Color(0xffE5E7EB),
        to: Color(0xffF3F4F6),
      );

  static SwitchAnimationConfig get skeletonizerAnimationConfig =>
      const SwitchAnimationConfig(
        duration: Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
      );

  static ThemeData themeData() {
    final textStyles = AppStyles();

    final colors = FThemes.zinc.light.colorScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: colors.primary,
        onPrimary: colors.primaryForeground,
        secondary: colors.secondary,
        onSecondary: colors.secondaryForeground,
        error: colors.destructive,
        onError: colors.destructiveForeground,
        surface: colors.background,
        onSurface: colors.foreground,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        backgroundColor: colors.background,
        foregroundColor: colors.foreground,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textStyles.button1.copyWith(color: colors.foreground),
        elevation: 0,
      ),
      iconTheme: IconThemeData(color: colors.foreground),
      dividerTheme: DividerThemeData(
        color: colors.border,
      ),
      cardColor: colors.background,
      splashColor: colors.border,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: colors.border,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.resolveWith((_) => colors.foreground),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          } else if (states.contains(WidgetState.focused)) {
            return colors.foreground;
          }

          return colors.foreground;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: BorderSide(color: colors.border),
      ),
      chipTheme: ChipThemeData(
        selectedColor: colors.primary,
        backgroundColor: colors.background,
      ),
      dividerColor: colors.border,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.background,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          shape: const StadiumBorder(),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
      ),
      scaffoldBackgroundColor: colors.background,
      textSelectionTheme: TextSelectionThemeData(
        // cursorColor: Color.fromRGBO(66, 133, 244, 1.0),
        selectionColor: colors.background.withOpacity(.2),
        selectionHandleColor: colors.background.withOpacity(.2),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.background;
          }

          return colors.background;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }

          return colors.border;
        }),
      ),
      // pageTransitionsTheme: const CustomCupertinoTransitionsTheme(),
      textTheme: TextTheme(
        displayLarge: textStyles.h1.copyWith(color: colors.primary),
        displayMedium: textStyles.h2.copyWith(color: colors.primary),
        displaySmall: textStyles.h3.copyWith(color: colors.primary),
        headlineLarge: textStyles.h4.copyWith(color: colors.primary),
        headlineMedium: textStyles.h4.copyWith(color: colors.primary),
        headlineSmall: textStyles.h5.copyWith(color: colors.primary),
        titleLarge: textStyles.h6.copyWith(color: colors.primary),
        titleMedium: textStyles.button1.copyWith(color: colors.primary),
        titleSmall: textStyles.button2.copyWith(color: colors.primary),
        labelLarge: textStyles.button1.copyWith(color: colors.primary),
        labelMedium: textStyles.button2.copyWith(color: colors.primary),
        labelSmall: textStyles.button3.copyWith(color: colors.primary),
        bodyLarge: textStyles.body1.copyWith(color: colors.primary),
        bodyMedium: textStyles.body2.copyWith(color: colors.primary),
        bodySmall: textStyles.body3.copyWith(color: colors.primary),
      ),
      extensions: [
        AppThemeExtension(
          styles: textStyles,
        ),
      ],
    );
  }
}
