import 'package:flutter/material.dart';
import 'package:pirooz_timeline/src/indicator_alignment.dart';
import 'package:pirooz_timeline/src/pirooz_model.dart';

import 'builders.dart';
import 'connector_style.dart';

class PiroozTimeline extends StatelessWidget {
  final List<PiroozModel> models;
  final IndicatorBuilder indicatorBuilder;
  final ItemBuilder widgetBuilder;
  final int flex;
  final ConnectorStyle connectorStyle;
  final IndicatorAlignment indicatorAlignment;
  final ScrollPhysics? scrollPhysics;

  const PiroozTimeline({
    super.key,
    required this.models,
    required this.indicatorBuilder,
    this.scrollPhysics,
    this.indicatorAlignment = IndicatorAlignment.center,
    required this.widgetBuilder,
    required this.flex,
    ConnectorStyle? connectorStyle,
  }) : connectorStyle =
            connectorStyle ?? const ConnectorStyle(width: null, color: null);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: models.length,
      shrinkWrap: true,
      physics: scrollPhysics ?? const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _PiroozTile(
          connectorStyle: connectorStyle,
          key: ValueKey(index),
          indicatorAlignment: indicatorAlignment,
          flex: flex,
          indicator: indicatorBuilder.call(models[index], index),
          ignorePrevious: index == 0 || models[index].ignorePrevious,
          ignoreNext: index == models.length - 1 || models[index].ignoreNext,
          child: widgetBuilder.call(models[index], index),
        );
      },
    );
  }
}

class _PiroozTile extends StatelessWidget {
  final bool ignorePrevious;
  final bool ignoreNext;
  final Widget indicator;
  final Widget child;
  final int flex;
  final ConnectorStyle connectorStyle;
  final IndicatorAlignment indicatorAlignment;

  const _PiroozTile(
      {super.key,
      required this.ignorePrevious,
      required this.indicator,
      required this.child,
      required this.flex,
      required this.ignoreNext,
      required this.connectorStyle,
      required this.indicatorAlignment});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _showBefore(),
                    Container(
                        alignment: const Alignment(-1, 0), child: indicator),
                    _showAfter()
                  ],
                ),
              ),
              Expanded(flex: flex, child: child)
            ],
          ),
        );
      },
    );
  }

  _showBefore() {
    if (indicatorAlignment == IndicatorAlignment.top) {
      return Container();
    }
    if (ignorePrevious) {
      if (connectorStyle.showLineBeforeFirst) {
        return Expanded(
          child: Container(
            padding: connectorStyle.padding,
            alignment: const Alignment(-1, 0),
            child: CustomPaint(
              painter: _DashLinePainter(
                  dashSpace: connectorStyle.dashSpace,
                  dashHeight: connectorStyle.dashHeight,
                  dashColor: connectorStyle.dashColor),
              size: Size(connectorStyle.width, double.infinity),
            ),
          ),
        );
      } else {
        return Expanded(
          child: SizedBox(
            width: connectorStyle.width,
            height: double.infinity,
            child: Container(),
          ),
        );
      }
    } else {
      return Expanded(
        child: Container(
          padding: connectorStyle.padding,
          alignment: const Alignment(-1, 0),
          child: CustomPaint(
            painter: _DashLinePainter(
                dashColor: connectorStyle.dashColor,
                dashSpace: connectorStyle.dashSpace,
                dashHeight: connectorStyle.dashHeight),
            size: Size(connectorStyle.width, double.infinity),
          ),
        ),
      );
    }
  }

  _showAfter() {
    if (indicatorAlignment == IndicatorAlignment.bottom) {
      return Container();
    }
    if (ignoreNext) {
      if (connectorStyle.showLineAfterLast) {
        return Expanded(
          child: Container(
            padding: connectorStyle.padding,
            alignment: const Alignment(-1, 0),
            child: CustomPaint(
              painter: _DashLinePainter(
                  dashColor: connectorStyle.dashColor,
                  dashSpace: connectorStyle.dashSpace,
                  dashHeight: connectorStyle.dashHeight),
              size: Size(connectorStyle.width, double.infinity),
            ),
          ),
        );
      } else {
        return Expanded(
          child: SizedBox(
            width: connectorStyle.width,
            height: double.infinity,
            child: Container(),
          ),
        );
      }
    } else {
      return Expanded(
          child: Container(
        padding: connectorStyle.padding,
        alignment: const Alignment(-1, 0),
        child: CustomPaint(
          painter: _DashLinePainter(
              dashColor: connectorStyle.dashColor,
              dashSpace: connectorStyle.dashSpace,
              dashHeight: connectorStyle.dashHeight),
          size: Size(connectorStyle.width, double.infinity),
        ),
      ));
    }
  }
}

class _DashLinePainter extends CustomPainter {
  final double dashHeight;
  final double dashSpace;
  final Color dashColor;

  const _DashLinePainter(
      {this.dashHeight = 3, this.dashSpace = 2, this.dashColor = Colors.grey});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = dashColor
      ..strokeWidth = size.width;
    double start = 0;
    while (start < size.height) {
      canvas.drawLine(Offset(0, start), Offset(0, start + dashHeight), paint);
      start += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
