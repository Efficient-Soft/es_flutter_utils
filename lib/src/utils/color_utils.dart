import 'dart:math' as math;
import 'package:flutter/material.dart';

Color getColorFromName(String colorName) {
  final colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'black': Colors.black,
    'white': Colors.white,
    'gray': Colors.grey,
    'silver': const Color(0xFFC0C0C0),
    'gold': const Color(0xFFFFD700),
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'brown': Colors.brown,
    'maroon': const Color(0xFF800000),
    'navy': const Color(0xFF000080),
    'beige': const Color(0xFFF5F5DC),
    'ivory': const Color(0xFFFFFFF0),
    'charcoal': const Color(0xFF36454F),
    'lime': const Color(0xFFBFFF00),
    'teal': Colors.teal,
    'cyan': Colors.cyan,
    'magenta': const Color(0xFFFF00FF),
    'bronze': const Color(0xFFCD7F32),
    'champagne': const Color(0xFFF7E7CE),
    'pearl': const Color(0xFFEAE0C8),
    'turquoise': const Color(0xFF40E0D0),
    'mint': const Color(0xFF98FF98),
    'indigo': const Color(0xFF4B0082),
    'olive': const Color(0xFF808000),
  };

  return colorMap[colorName.toLowerCase()] ?? Colors.transparent;
}

Color generateRandomColor() {
  return Color(math.Random().nextInt(0xffffff + 1) | 0xff000000);
}
