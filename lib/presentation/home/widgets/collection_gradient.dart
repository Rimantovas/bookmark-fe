import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mesh/mesh.dart';

class CollectionGradient extends StatelessWidget {
  const CollectionGradient({super.key, required this.id});

  final String id;

  HSLColor get mainColor {
    final hash = id.hashCode.abs();
    final mainHue = (hash % 360).toDouble();
    const mainSaturation = 0.8;
    const mainLightness = 0.45;
    final mainColor =
        HSLColor.fromAHSL(1.0, mainHue, mainSaturation, mainLightness);
    return mainColor;
  }

  List<OVertex> _generateVertices() {
    final hash = id.hashCode.abs();
    final random = Random(hash);

    // Helper function to add small random variation
    double vary(double base, double range) =>
        base + (random.nextDouble() - 0.5) * range;

    return [
      // Row 1 - Top edge
      (vary(-0.05, 0.02), vary(-0.05, 0.02)).v,
      (vary(0.25, 0.02), vary(-0.07, 0.02)).v,
      (vary(0.5, 0.02), vary(-0.1, 0.02)).v,
      (vary(0.75, 0.02), vary(-0.07, 0.02)).v,
      (vary(1.05, 0.02), vary(-0.05, 0.02)).v,

      // Row 3 - Middle (with bezier curves for smooth transition)
      (-0.05, vary(0.45, 0.02)).v,
      (0.15, 0.6).v.bezier(
            east: (0.25, 0.57).v,
            west: (0.05, 0.63).v,
          ),
      (0.5, 0.45).v.bezier(
            east: (0.65, 0.43).v,
            west: (0.35, 0.47).v,
          ),
      (0.8, 0.5).v.bezier(
            east: (0.9, 0.5).v,
            west: (0.7, 0.48).v,
          ),
      (1.05, vary(0.45, 0.02)).v,

      // Row 4 - Lower blend

      // Row 5 - Bottom edge
      (vary(-0.05, 0.02), 1.05).v,
      (vary(0.35, 0.05), 1.05).v,
      (vary(0.65, 0.05), 1.05).v,
      (vary(0.9, 0.05), 1.05).v,
      (vary(1.05, 0.02), 1.05).v,
    ];
  }

  List<Color> _generateColors() {
    final hash = id.hashCode.abs();
    final mainHue = (hash % 360).toDouble();
    const mainSaturation = 0.8;
    const mainLightness = 0.45;

    // Create main color and its variants

    final splitComplement1 = HSLColor.fromAHSL(
        1.0, (mainHue + 150) % 360, mainSaturation - 0.1, mainLightness + 0.05);
    final splitComplement2 = HSLColor.fromAHSL(
        1.0, (mainHue + 210) % 360, mainSaturation - 0.1, mainLightness + 0.05);

    // Return colors for 5x5 grid with null for transparency
    return [
      // Row 2 - Main color with high opacity
      mainColor.withAlpha(0.9).toColor(),
      mainColor.withAlpha(0.95).toColor(),
      mainColor.toColor(),
      mainColor.withAlpha(0.95).toColor(),
      mainColor.withAlpha(0.9).toColor(),

      // Row 3 - Blend of split complements
      splitComplement1.withAlpha(0.7).toColor(),
      splitComplement1.withAlpha(0.8).toColor(),
      mainColor.withAlpha(0.9).toColor(),
      splitComplement2.withAlpha(0.8).toColor(),
      splitComplement2.withAlpha(0.7).toColor(),

      // Row 4 - Darker split complements
      splitComplement1.withAlpha(0.8).toColor(),
      splitComplement1.withAlpha(0.9).toColor(),
      mainColor.withAlpha(0.8).toColor(),
      splitComplement2.withAlpha(0.9).toColor(),
      splitComplement2.withAlpha(0.8).toColor(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: mainColor.toColor(),
      child: OMeshGradient(
        mesh: OMeshRect(
          width: 3,
          height: 5,
          vertices: _generateVertices(),
          colors: _generateColors(),
          fallbackColor: _generateColors()[7], // Use main color as fallback
          backgroundColor: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
