import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/tappable.dart';
import 'package:flutter/material.dart';

class CTAButton extends StatelessWidget {
  const CTAButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.bgColor,
    this.textColor,
  });

  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool isLoading;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = this.bgColor ?? context.colors.primary;
    final textColor = this.textColor ?? context.colors.primary;

    return Tappable.animated(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: bgColor,
        ),
        padding: const EdgeInsets.all(8),
        height: 56,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  Expanded(
                      child: Center(
                    child: Text(
                      text,
                      style: context.styles.button1.copyWith(color: textColor),
                    ),
                  )),
                  if (icon != null)
                    Visibility(
                      maintainSize: true,
                      child: icon!,
                    ),
                ],
              ),
      ),
    );
  }
}
