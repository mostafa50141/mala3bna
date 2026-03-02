import 'dart:ui';

import 'package:flutter/material.dart';

abstract class Style {
  static final textStyle35Bold = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 35),
    fontWeight: FontWeight.bold,
  );
  static final textStyle30Bold = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 30),
    fontWeight: FontWeight.bold,
  );
  static final textStyleBold26 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 26),

    fontWeight: FontWeight.bold,
  );

  static final textStyle26 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 26),
  );
  static final textStyle20 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 20),
    fontWeight: FontWeight.w600,
  );
  static final textStyle20Bold = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 20),
    fontWeight: FontWeight.bold,
  );
  static final textStyle16 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 16),
    fontWeight: FontWeight.normal,
  );
  static final textStyle16Bold = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 16),
    fontWeight: FontWeight.bold,
  );
  static final textStyle14 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 14),
    fontWeight: FontWeight.normal,
  );
  static final textStyle14Bold = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 14),
    fontWeight: FontWeight.bold,
  );

  static final textStyle12 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 12),
    fontWeight: FontWeight.normal,
  );

  static final textStyle12Bold = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 12),
    fontWeight: FontWeight.bold,
  );

  static final textStyle18 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 18),
  );
  static final textStyle18Bold = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 18),

    fontWeight: FontWeight.bold,
  );

  static double getResponsiveFontSize({required double fontSize}) {
    double scalerFactor = getScalerFector();
    double responsiveFontSize = fontSize * scalerFactor;
    double lowerLimit = fontSize * 0.8;
    double upperLimit = fontSize * 1.2;
    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }

  static double getScalerFector() {
    var dispatcher = PlatformDispatcher.instance;
    var physicalWidth = dispatcher.views.first.physicalSize.width;
    var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
    double width = physicalWidth / devicePixelRatio;
    if (width < 800) {
      return width / 650;
    } else if (width < 1300) {
      return width / 1000;
    } else {
      return width / 1850;
    }
  }
}
