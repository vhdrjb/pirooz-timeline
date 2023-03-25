<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Pirooz Timeline is a customizable timeline. You can set your widget for indicator and the items,so you can create any
timeline.

The name of library is **Pirooz** inspired of iranian cheetah cub.

## Getting started

To use **Pirooz Timeline** in your project, add the `pirooz_timeline` to your `pubspec.yaml`

Import the package to use it:

```dart
import 'package:pirooz_timeline/pirooz_timeline.dart';
```

## Usage

```
PiroozTimeline(flex: 5,
  indicatorAlignment: IndicatorAlignment.top,
  indicatorBuilder: (model, index) {},
  connectorStyle: const ConnectorStyle(
    color: Colors.amber,
    dashSpace: 4,
    dashHeight: 5,
  ),
  models: const [],
  widgetBuilder: (PiroozModel model, int index) {},
)
```

## Syntax

- `flex` : proportion of item and it's indicator
- `indicatorAlignment` : enum that contains three `top`,`bottom` and `center` alignment for indicator.
- `indicatorBuilder`: a builder that gives you the model and index of the model, and you can create different indicators
  base on model `runtimeType` or index of it.
- `physics` : scrolling physics. Default is `NeverScrollableScrollPhysics`
- `connectorStyle`: Style of vertical dashes contains following properties:
    - `color` : color of dashes
    - `dashSpace` : space between dashes
    - `dashHeight` : height of each dash
    - `width` : width of each dash
    - `showLineBeforeFirst` : by default, showing dashes before first line has not good look for timeline. Dashes are
      seperated in two part, before indicator and after indicator. By setting this property `true` dash before indicator
      will be shown
    - `showLineAfterLast` : by default, showing dashes after last line has not good look for timeline. Dashes are
      seperated in two part, before indicator and after indicator. By setting this property `true` dash after indicator
      will be shown
    - `padding` : padding of connectors
- `models` : list of item's that should be displayed in timeline. Each model should be subtype of `PiroozModel`. If previous or next indicator of models should be ignored, it can be handled by `ignoreNext` and `ignorePrevious` parameter. 
- `widgetBuilder` : a builder that gives you the model and index of the model, and you can create different items base
  on model `runtimeType` or index of it.

