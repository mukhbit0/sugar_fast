import 'package:flutter/material.dart';

/// Debug utilities for Sugar Fast widgets
class SugarDebug {
  static bool _showSugarWidgetBounds = false;
  static bool _logPerformanceMetrics = false;

  /// Whether to show visual bounds around Sugar widgets for debugging
  static bool get showSugarWidgetBounds => _showSugarWidgetBounds;

  /// Enable/disable visual bounds around Sugar widgets
  static set showSugarWidgetBounds(bool value) {
    _showSugarWidgetBounds = value;
  }

  /// Whether to log performance metrics for Sugar widgets
  static bool get logPerformanceMetrics => _logPerformanceMetrics;

  /// Enable/disable performance logging for Sugar widgets
  static set logPerformanceMetrics(bool value) {
    _logPerformanceMetrics = value;
  }

  /// Log a performance metric
  static void logPerformance(
      String widgetType, String operation, int durationMicros) {
    if (_logPerformanceMetrics) {
      print('Sugar $widgetType: $operation took ${durationMicros}μs');
    }
  }

  /// Paint debug bounds for a widget
  static void paintBounds(Canvas canvas, Rect bounds, Color color) {
    if (_showSugarWidgetBounds) {
      final paint = Paint()
        ..color = color.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawRect(bounds, paint);

      // Paint center point
      canvas.drawCircle(
        bounds.center,
        2.0,
        Paint()..color = color,
      );
    }
  }
}
