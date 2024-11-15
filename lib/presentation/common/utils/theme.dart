import 'package:app/presentation/common/utils/colors.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/utils/styles.dart';
import 'package:app/presentation/common/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppTheme {
  static ColorScheme get colorScheme {
    final colors = AppColors();
    return ColorScheme.dark(
      primary: colors.primary,
      secondary: colors.dark,
    );
  }

  static PaintingEffect skeletonizerEffect(BuildContext context) => PulseEffect(
        from: context.colors.dark.withOpacity(.5),
        to: context.colors.grey,
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
    final colors = AppColors();
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        backgroundColor: colors.white,
        foregroundColor: colors.dark,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textStyles.button1.copyWith(color: colors.dark),
        elevation: 0,
      ),
      dividerTheme: DividerThemeData(
        color: colors.grey,
      ),
      cardColor: colors.white,
      splashColor: colors.grey,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: colors.grey,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.resolveWith((_) => colors.white),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          } else if (states.contains(WidgetState.focused)) {
            return colors.dark;
          }

          return colors.dark;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: BorderSide(color: colors.grey),
      ),
      chipTheme: ChipThemeData(
        selectedColor: colors.primary,
        backgroundColor: colors.dark,
      ),
      dividerColor: colors.grey,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.white,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          shape: const StadiumBorder(),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
      ),
      scaffoldBackgroundColor: colors.white,
      textSelectionTheme: TextSelectionThemeData(
        // cursorColor: Color.fromRGBO(66, 133, 244, 1.0),
        selectionColor: colors.white.withOpacity(.2),
        selectionHandleColor: colors.white.withOpacity(.2),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.white;
          }

          return colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }

          return colors.grey;
        }),
      ),
      // pageTransitionsTheme: const CustomCupertinoTransitionsTheme(),
      textTheme: TextTheme(
        displayLarge: textStyles.h1.copyWith(color: colors.dark),
        displayMedium: textStyles.h2.copyWith(color: colors.dark),
        displaySmall: textStyles.h3.copyWith(color: colors.dark),
        headlineLarge: textStyles.h4.copyWith(color: colors.dark),
        headlineMedium: textStyles.h4.copyWith(color: colors.dark),
        headlineSmall: textStyles.h5.copyWith(color: colors.dark),
        titleLarge: textStyles.h6.copyWith(color: colors.dark),
        titleMedium: textStyles.button1.copyWith(color: colors.dark),
        titleSmall: textStyles.button2.copyWith(color: colors.dark),
        labelLarge: textStyles.button1.copyWith(color: colors.dark),
        labelMedium: textStyles.button2.copyWith(color: colors.dark),
        labelSmall: textStyles.button3.copyWith(color: colors.dark),
        bodyLarge: textStyles.body1.copyWith(color: colors.dark),
        bodyMedium: textStyles.body2.copyWith(color: colors.dark),
        bodySmall: textStyles.body3.copyWith(color: colors.dark),
      ),
      extensions: [
        AppThemeExtension(
          colors: colors,
          styles: textStyles,
        ),
      ],
    );
  }
}
