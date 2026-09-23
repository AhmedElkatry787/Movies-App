import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Width of the frame the designs are measured on.
const double kDesignFrameWidth = 430;

/// Phone-sized content stops growing past this width: forms are centered at
/// this width on tablets and in landscape, and [ResponsiveContext.scaled]
/// sizes stop scaling up.
const double kMaxContentWidth = 500;

extension ResponsiveContext on BuildContext {
  /// Scales [designSize], measured on the 430px design frame, to this screen.
  ///
  /// It follows the screen's shortest side, so a rotated phone keeps its
  /// portrait sizes, and it stops growing at [kMaxContentWidth], so tablets
  /// get more room rather than giant widgets.
  double scaled(double designSize) {
    final shortestSide = MediaQuery.sizeOf(this).shortestSide;
    return designSize * math.min(shortestSide, kMaxContentWidth) / kDesignFrameWidth;
  }

  /// Padding for a phone-style column of content, such as a form. The sides
  /// are at least [horizontal], and widen on tablets and in landscape so the
  /// content stays [kMaxContentWidth] wide and centered.
  EdgeInsets contentPadding({required double horizontal, double vertical = 0}) {
    final width = MediaQuery.sizeOf(this).width;
    final side = math.max(horizontal, (width - kMaxContentWidth) / 2);
    return EdgeInsets.symmetric(horizontal: side, vertical: vertical);
  }
}
