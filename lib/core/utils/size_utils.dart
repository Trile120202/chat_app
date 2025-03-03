// TODO Implement this library.

import 'dart:math';

import 'package:flutter/material.dart';

const num WIDTH = 393;
const num HEIGHT = 852;
const num STATUS_BAR = 0;

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get h => ((this * _width) / WIDTH);
  double get fSize => ((this * _width) / WIDTH);
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuilder = Widget Function(
    BuildContext context, Orientation orientation, DeviceType deviceType);

class Sizer extends StatelessWidget {
  const Sizer({
    Key? key,
    required this.builder,
  }) : super(key: key);
  final ResponsiveBuilder builder;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constaints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(constaints, orientation);
        return builder(context, orientation, SizeUtils.deviceType);
      });
    });
  }
}

//ignore_for _file: must_be_immutable

class SizeUtils {
  static late BoxConstraints boxConstraints;

  static late Orientation orientation;

  //Type of device

  //This can either be mobile or tablet

  static late DeviceType deviceType;

  //Divece's Height
  static late double height;
  //Divece's Width
  static late double width;

  static void setScreenSize(
      BoxConstraints constaints, Orientation currentOrientation) {
    boxConstraints = constaints;
    orientation = currentOrientation;
    if (orientation == Orientation.portrait) {
      height = boxConstraints.maxHeight.isNonZero();
      width = boxConstraints.maxWidth.isNonZero(defaultValue: WIDTH);
    } else {
      height = boxConstraints.maxWidth.isNonZero();
      width = boxConstraints.maxHeight.isNonZero(defaultValue: WIDTH);
    }
    deviceType = DeviceType.mobile;
  }
}
