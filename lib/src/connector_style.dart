import 'package:flutter/material.dart';

class ConnectorStyle {
  final Color dashColor;
  final double width;
  final bool showLineAfterLast;
  final bool showLineBeforeFirst;
  final double dashSpace;
  final double dashHeight;
  final double ratio;

  const ConnectorStyle(
      {double? width,
      double? dashHeight,
      double? dashSpace,
      Color? color,
      this.showLineAfterLast = false,
      this.ratio = 0.5,
      this.showLineBeforeFirst = false})
      : dashColor = color ?? Colors.grey,
        dashSpace = dashSpace ?? 2,
        dashHeight = dashHeight ?? 10,
        width = width ?? 2;
}
