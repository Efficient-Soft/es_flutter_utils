import 'package:flutter/material.dart';
import '../models/widget_metadata.dart';

void registerPostFrameCallback(VoidCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) => callback());
}

Offset? getWidgetPosition(GlobalKey key) {
  final RenderBox? renderBox =
      key.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox != null) {
    return renderBox.localToGlobal(Offset.zero);
  }
  return null;
}

WidgetMetaData? getWidgetMetaData(GlobalKey key) {
  try {
    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    return WidgetMetaData(
      position: offset,
      size: renderBox.size,
      constraints: renderBox.constraints,
    );
  } catch (e) {
    return null;
  }
}

SliverList testSliverList() => SliverList.builder(
  addAutomaticKeepAlives: false,
  itemBuilder: (context, index) => ListTile(title: Text(index.toString())),
);
