import 'package:app/presentation/common/widgets/auth_sheet.dart';
import 'package:app/presentation/common/widgets/premium_sheet.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

void showAuthSheet(BuildContext context, {required String feature}) {
  showFSheet(
    context: context,
    side: FLayout.btt,
    constraints: const BoxConstraints(maxWidth: 450),
    builder: (context) => AuthSheet(
      title: 'Sign in required',
      description: 'Please sign in to $feature and unlock all features.',
      onSignInPressed: () {},
    ),
  );
}

void showPremiumSheet(BuildContext context) {
  showFSheet(
    context: context,
    side: FLayout.btt,
    constraints: const BoxConstraints(maxWidth: 450),
    builder: (BuildContext context) {
      return const PremiumSheet();
    },
  );
}
