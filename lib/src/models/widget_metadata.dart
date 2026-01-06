import 'package:flutter/material.dart';

class WidgetMetaData {
  final Offset position;
  final Size size;
  final BoxConstraints constraints;

  WidgetMetaData({
    required this.position,
    required this.size,
    required this.constraints,
  });

  WidgetMetaData copyWith({
    Offset? position,
    Size? size,
    BoxConstraints? constraints,
  }) {
    return WidgetMetaData(
      position: position ?? this.position,
      size: size ?? this.size,
      constraints: constraints ?? this.constraints,
    );
  }

  @override
  String toString() =>
      'WidgetMetaData(position: $position, size: $size, constraints: $constraints)';
}
