import 'dart:io';

import 'package:flutter/services.dart';

enum HapticFeedbackStrength {
  vibrate,
  selection,
  light,
  medium,
  heavy,
}

class AppVibrationFunction {
  AppVibrationFunction(
    this.originalFunction, {
    this.hapticFeedbackStrength,
  }) {
    callFunction();
  }
  final void Function()? originalFunction;
  final HapticFeedbackStrength? hapticFeedbackStrength;

  void callFunction() {
    // final usersBloc = GetIt.instance<UsersBloc>();
    // final isVibrationEnabled = usersBloc.user?.isVibrationEnabled ?? false;

    // if (isVibrationEnabled)
    vibrate();
    originalFunction?.call();
  }

  void vibrate() {
    final localHapticFeedbackStrength = hapticFeedbackStrength;

    // Different handling per device. On Android `selectionClick` does not work
    if (localHapticFeedbackStrength == null) {
      if (Platform.isIOS) {
        HapticFeedback.selectionClick();
      } else {
        HapticFeedback.vibrate();
      }

      return;
    }

    switch (localHapticFeedbackStrength) {
      case HapticFeedbackStrength.vibrate:
        HapticFeedback.vibrate();
      case HapticFeedbackStrength.selection:
        HapticFeedback.selectionClick();
      case HapticFeedbackStrength.light:
        HapticFeedback.lightImpact();
      case HapticFeedbackStrength.medium:
        HapticFeedback.mediumImpact();
      case HapticFeedbackStrength.heavy:
        HapticFeedback.heavyImpact();
    }
  }
}
