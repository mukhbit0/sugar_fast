import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// A text widget that avoids full rebuilds when only the text changes,
/// with built-in emoji font fallback.
class SugarText extends LeafRenderObjectWidget {
  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const SugarText(
    this.text, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    final resolvedStyle =
        DefaultTextStyle.of(context).style.merge(style).copyWith(
      fontFamilyFallback: [
        'Noto Color Emoji', // Android
        'Apple Color Emoji', // iOS
        'Segoe UI Emoji', // Windows
      ],
    );

    return _SugarTextRenderBox(
      text: text,
      style: resolvedStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection ?? Directionality.of(context),
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _SugarTextRenderBox renderObject) {
    final resolvedStyle =
        DefaultTextStyle.of(context).style.merge(style).copyWith(
      fontFamilyFallback: [
        'Noto Color Emoji',
        'Apple Color Emoji',
        'Segoe UI Emoji',
      ],
    );

    renderObject
      ..text = text
      ..style = resolvedStyle
      ..strutStyle = strutStyle
      ..textAlign = textAlign
      ..textDirection = textDirection ?? Directionality.of(context)
      ..locale = locale
      ..softWrap = softWrap
      ..overflow = overflow
      ..textScaleFactor = textScaleFactor
      ..textScaler = textScaler
      ..maxLines = maxLines
      ..textWidthBasis = textWidthBasis
      ..textHeightBehavior = textHeightBehavior
      ..selectionColor = selectionColor;
  }
}

class _SugarTextRenderBox extends RenderBox {
  late TextPainter _textPainter;
  String _text;
  TextStyle? _style;
  StrutStyle? _strutStyle;
  TextAlign? _textAlign;
  TextDirection _textDirection;
  Locale? _locale;
  bool? _softWrap;
  TextOverflow? _overflow;
  double? _textScaleFactor;
  TextScaler? _textScaler;
  int? _maxLines;
  TextWidthBasis? _textWidthBasis;
  ui.TextHeightBehavior? _textHeightBehavior;
  Color? _selectionColor;

  _SugarTextRenderBox({
    required String text,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    required TextDirection textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    TextScaler? textScaler,
    int? maxLines,
    TextWidthBasis? textWidthBasis,
    ui.TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  })  : _text = text,
        _style = style,
        _strutStyle = strutStyle,
        _textAlign = textAlign,
        _textDirection = textDirection,
        _locale = locale,
        _softWrap = softWrap,
        _overflow = overflow,
        _textScaleFactor = textScaleFactor,
        _textScaler = textScaler,
        _maxLines = maxLines,
        _textWidthBasis = textWidthBasis,
        _textHeightBehavior = textHeightBehavior,
        _selectionColor = selectionColor {
    _createTextPainter();
  }

  void _createTextPainter() {
    _textPainter = TextPainter(
      text: TextSpan(
        text: _text,
        style: _style,
      ),
      textAlign: _textAlign ?? TextAlign.start,
      textDirection: _textDirection,
      locale: _locale,
      textScaler: _textScaler ??
          (_textScaleFactor != null
              ? TextScaler.linear(_textScaleFactor!)
              : TextScaler.noScaling),
      maxLines: _maxLines,
      strutStyle: _strutStyle,
      textWidthBasis: _textWidthBasis ?? TextWidthBasis.parent,
      textHeightBehavior: _textHeightBehavior,
    );
  }

  void _updateTextPainter() {
    _textPainter.dispose();
    _createTextPainter();
  }

  // Getters and setters with proper invalidation
  String get text => _text;
  set text(String value) {
    if (_text != value) {
      _text = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  TextStyle? get style => _style;
  set style(TextStyle? value) {
    if (_style != value) {
      _style = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  StrutStyle? get strutStyle => _strutStyle;
  set strutStyle(StrutStyle? value) {
    if (_strutStyle != value) {
      _strutStyle = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  TextAlign? get textAlign => _textAlign;
  set textAlign(TextAlign? value) {
    if (_textAlign != value) {
      _textAlign = value;
      _updateTextPainter();
      markNeedsPaint();
    }
  }

  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection != value) {
      _textDirection = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  Locale? get locale => _locale;
  set locale(Locale? value) {
    if (_locale != value) {
      _locale = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  bool? get softWrap => _softWrap;
  set softWrap(bool? value) {
    if (_softWrap != value) {
      _softWrap = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  TextOverflow? get overflow => _overflow;
  set overflow(TextOverflow? value) {
    if (_overflow != value) {
      _overflow = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  double? get textScaleFactor => _textScaleFactor;
  set textScaleFactor(double? value) {
    if (_textScaleFactor != value) {
      _textScaleFactor = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  TextScaler? get textScaler => _textScaler;
  set textScaler(TextScaler? value) {
    if (_textScaler != value) {
      _textScaler = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  int? get maxLines => _maxLines;
  set maxLines(int? value) {
    if (_maxLines != value) {
      _maxLines = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  TextWidthBasis? get textWidthBasis => _textWidthBasis;
  set textWidthBasis(TextWidthBasis? value) {
    if (_textWidthBasis != value) {
      _textWidthBasis = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  ui.TextHeightBehavior? get textHeightBehavior => _textHeightBehavior;
  set textHeightBehavior(ui.TextHeightBehavior? value) {
    if (_textHeightBehavior != value) {
      _textHeightBehavior = value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  Color? get selectionColor => _selectionColor;
  set selectionColor(Color? value) {
    if (_selectionColor != value) {
      _selectionColor = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    _textPainter.layout(maxWidth: constraints.maxWidth);
    size = constraints.constrain(Size(
      _textPainter.width,
      _textPainter.height,
    ));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _textPainter.layout(maxWidth: constraints.maxWidth);
    _textPainter.paint(context.canvas, offset);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    _textPainter.layout();
    return _textPainter.minIntrinsicWidth;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    _textPainter.layout();
    return _textPainter.maxIntrinsicWidth;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    _textPainter.layout(maxWidth: width);
    return _textPainter.height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    _textPainter.layout(maxWidth: width);
    return _textPainter.height;
  }

  @override
  void dispose() {
    _textPainter.dispose();
    super.dispose();
  }
}
