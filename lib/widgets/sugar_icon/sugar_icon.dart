import 'package:flutter/material.dart';
import '../../core/sugar_debug.dart';

/// An icon widget that uses direct painting for optimal performance.
/// Feature-complete replacement for Icon widget.
class SugarIcon extends LeafRenderObjectWidget {
  final IconData icon;
  final double size;
  final Color color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  const SugarIcon(
    this.icon, {
    super.key,
    this.size = 24.0,
    this.color = Colors.black,
    this.semanticLabel,
    this.textDirection,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SugarIconRenderBox(
      icon: icon,
      size: size,
      color: color,
      textDirection: textDirection ?? Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _SugarIconRenderBox renderObject) {
    renderObject
      ..icon = icon
      ..iconSize = size
      ..color = color
      ..textDirection = textDirection ?? Directionality.of(context);
  }
}

class _SugarIconRenderBox extends RenderBox {
  late TextPainter _textPainter;
  IconData _icon;
  double _size;
  Color _color;
  TextDirection _textDirection;

  _SugarIconRenderBox({
    required IconData icon,
    required double size,
    required Color color,
    required TextDirection textDirection,
  })  : _icon = icon,
        _size = size,
        _color = color,
        _textDirection = textDirection {
    _createTextPainter();
  }

  void _createTextPainter() {
    _textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(_icon.codePoint),
        style: TextStyle(
          inherit: false,
          color: _color,
          fontSize: _size,
          fontFamily: _icon.fontFamily,
          package: _icon.fontPackage,
        ),
      ),
      textDirection: _textDirection,
      textAlign: TextAlign.center,
    );
  }

  // Getters and setters with proper invalidation
  IconData get icon => _icon;
  set icon(IconData value) {
    if (_icon != value) {
      _icon = value;
      _createTextPainter(); // Icon change requires rebuilding TextPainter
      markNeedsLayout();
    }
  }

  double get iconSize => _size;
  set iconSize(double value) {
    if (_size != value) {
      _size = value;
      _createTextPainter(); // Size change requires rebuilding TextPainter
      markNeedsLayout();
    }
  }

  Color get color => _color;
  set color(Color value) {
    if (_color != value) {
      _color = value;
      _createTextPainter(); // Color change requires rebuilding TextPainter
      markNeedsPaint();
    }
  }

  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection != value) {
      _textDirection = value;
      _textPainter.textDirection = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    // Layout the icon text
    _textPainter.layout();

    // Set our size to the icon size (square)
    size = constraints.constrain(Size(_size, _size));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Always ensure text is laid out before painting
    _textPainter.layout();

    // Center the icon in our bounds
    final iconSize = _textPainter.size;
    final centerOffset = Offset(
      offset.dx + (size.width - iconSize.width) / 2,
      offset.dy + (size.height - iconSize.height) / 2,
    );

    // Paint the icon
    _textPainter.paint(context.canvas, centerOffset);

    // Debug visualization
    SugarDebug.paintBounds(
      context.canvas,
      Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
      Colors.blue,
    );
  }

  @override
  double computeMinIntrinsicWidth(double height) => _size;

  @override
  double computeMaxIntrinsicWidth(double height) => _size;

  @override
  double computeMinIntrinsicHeight(double width) => _size;

  @override
  double computeMaxIntrinsicHeight(double width) => _size;

  @override
  void dispose() {
    _textPainter.dispose();
    super.dispose();
  }
}
