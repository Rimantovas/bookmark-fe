import 'package:app/presentation/common/utils/extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class PremiumSheet extends StatelessWidget {
  const PremiumSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FTheme(
      data: FThemes.zinc.dark,
      child: Builder(builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: Container(
            color: context.colors.background,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: context.colors.foreground,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  24.heightBox,
                  _BuildIcons(),
                  8.heightBox,
                  Text(
                    'Tags are a premium feature',
                    style: context.styles.button1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.heightBox,
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Upgrade to premium to create unlimited tags',
                      style: context.styles.body2.copyWith(
                        color: context.colors.foreground.withAlpha(200),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  32.heightBox,
                  SizedBox(
                    width: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: FButton(
                        label: const Text('Go Premium'),
                        onPress: () {},
                      ),
                    ),
                  ),
                  8.heightBox,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _Icon {
  final SvgAsset icon;
  final Color color;

  _Icon({required this.icon, required this.color});
}

class _BuildIcons extends StatelessWidget {
  _BuildIcons({super.key});

  final icons = <_Icon>[
    _Icon(icon: FAssets.icons.alarmClock, color: Colors.red),
    _Icon(icon: FAssets.icons.calendar, color: Colors.green),
    _Icon(icon: FAssets.icons.ampersand, color: Colors.blue),
    _Icon(icon: FAssets.icons.antenna, color: Colors.yellow),
    _Icon(icon: FAssets.icons.bluetooth, color: Colors.purple),
  ];

  Widget _buildIcon(BuildContext context, SvgAsset icon, Color color) {
    return Container(
      width: 45,
      height: 45,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: context.colors.background,
          width: 4,
        ),
      ),
      child: FIcon(
        icon,
        size: 18,
        color: context.colors.foreground,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 150,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ...icons.mapIndexed((index, e) => Positioned(
                  left: index * 26,
                  child: _buildIcon(context, e.icon, e.color),
                ))
          ],
        ),
      ),
    );
  }
}
