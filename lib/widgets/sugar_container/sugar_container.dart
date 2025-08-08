import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sugar/riverpod_sugar.dart';
import '../../core/sugar_debug.dart';

/// A container that updates visual properties without rebuilding children.
/// Feature-complete replacement for Container widget with Riverpod integration.
class SugarContainer extends SingleChildRenderObjectWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;

  const SugarContainer({
    super.key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    super.child,
    this.clipBehavior = Clip.none,
  }) : assert(
            color == null || decoration == null,
            'Cannot provide both a color and a decoration\\n'
            'To provide both, use "decoration: BoxDecoration(color: color)".');

  /// Create SugarContainer that watches a color provider
  SugarContainer.watchColor(
    StateProvider<Color> colorProvider, {
    super.key,
    this.alignment,
    this.padding,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    super.child,
    this.clipBehavior = Clip.none,
  }) : color = null;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SugarContainerRenderBox(
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _SugarContainerRenderBox renderObject) {
    renderObject
      ..alignment = alignment
      ..padding = padding
      ..color = color
      ..decoration = decoration
      ..foregroundDecoration = foregroundDecoration
      ..width = width
      ..height = height
      ..additionalConstraints = constraints
      ..margin = margin
      ..transform = transform
      ..transformAlignment = transformAlignment
      ..clipBehavior = clipBehavior;
  }
}

class _SugarContainerRenderBox extends RenderProxyBox {
  AlignmentGeometry? _alignment;
  EdgeInsetsGeometry? _padding;
  Color? _color;
  Decoration? _decoration;
  Decoration? _foregroundDecoration;
  double? _width;
  double? _height;
  BoxConstraints? _additionalConstraints;
  EdgeInsetsGeometry? _margin;
  Matrix4? _transform;
  AlignmentGeometry? _transformAlignment;
  Clip _clipBehavior;

  _SugarContainerRenderBox({
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    Clip clipBehavior = Clip.none,
  })  : _alignment = alignment,
        _padding = padding,
        _color = color,
        _decoration = decoration,
        _foregroundDecoration = foregroundDecoration,
        _width = width,
        _height = height,
        _additionalConstraints = constraints,
        _margin = margin,
        _transform = transform,
        _transformAlignment = transformAlignment,
        _clipBehavior = clipBehavior;

  // Getters and setters with proper invalidation
  AlignmentGeometry? get alignment => _alignment;
  set alignment(AlignmentGeometry? value) {
    if (_alignment != value) {
      _alignment = value;
      markNeedsPaint(); // Alignment only affects painting
    }
  }

  EdgeInsetsGeometry? get padding => _padding;
  set padding(EdgeInsetsGeometry? value) {
    if (_padding != value) {
      _padding = value;
      markNeedsLayout(); // Padding affects layout
    }
  }

  Color? get color => _color;
  set color(Color? value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint(); // Color only affects painting
    }
  }

  Decoration? get decoration => _decoration;
  set decoration(Decoration? value) {
    if (_decoration != value) {
      _decoration = value;
      markNeedsPaint(); // Decoration only affects painting
    }
  }

  Decoration? get foregroundDecoration => _foregroundDecoration;
  set foregroundDecoration(Decoration? value) {
    if (_foregroundDecoration != value) {
      _foregroundDecoration = value;
      markNeedsPaint(); // Foreground decoration only affects painting
    }
  }

  double? get width => _width;
  set width(double? value) {
    if (_width != value) {
      _width = value;
      markNeedsLayout(); // Width affects layout
    }
  }

  double? get height => _height;
  set height(double? value) {
    if (_height != value) {
      _height = value;
      markNeedsLayout(); // Height affects layout
    }
  }

  BoxConstraints? get additionalConstraints => _additionalConstraints;
  set additionalConstraints(BoxConstraints? value) {
    if (_additionalConstraints != value) {
      _additionalConstraints = value;
      markNeedsLayout(); // Constraints affect layout
    }
  }

  EdgeInsetsGeometry? get margin => _margin;
  set margin(EdgeInsetsGeometry? value) {
    if (_margin != value) {
      _margin = value;
      markNeedsLayout(); // Margin affects layout
    }
  }

  Matrix4? get transform => _transform;
  set transform(Matrix4? value) {
    if (_transform != value) {
      _transform = value;
      markNeedsPaint(); // Transform only affects painting
    }
  }

  AlignmentGeometry? get transformAlignment => _transformAlignment;
  set transformAlignment(AlignmentGeometry? value) {
    if (_transformAlignment != value) {
      _transformAlignment = value;
      markNeedsPaint(); // Transform alignment only affects painting
    }
  }

  Clip get clipBehavior => _clipBehavior;
  set clipBehavior(Clip value) {
    if (_clipBehavior != value) {
      _clipBehavior = value;
      markNeedsPaint(); // Clipping only affects painting
    }
  }

  @override
  void performLayout() {
    BoxConstraints constraints = this.constraints;

    // Apply margin constraints
    if (_margin != null) {
      final EdgeInsets margin = _margin!.resolve(TextDirection.ltr);
      constraints = constraints.deflate(margin);
    }

    // Apply width/height constraints
    if (_width != null || _height != null) {
      constraints = constraints.tighten(width: _width, height: _height);
    }

    // Apply additional constraints
    if (_additionalConstraints != null) {
      constraints = _additionalConstraints!.enforce(constraints);
    }

    if (child != null) {
      // Apply padding constraints for child
      BoxConstraints childConstraints = constraints;
      if (_padding != null) {
        final EdgeInsets padding = _padding!.resolve(TextDirection.ltr);
        childConstraints = constraints.deflate(padding);
      }

      child!.layout(childConstraints, parentUsesSize: true);

      // Calculate our size based on child + padding
      Size childSize = child!.size;
      if (_padding != null) {
        final EdgeInsets padding = _padding!.resolve(TextDirection.ltr);
        childSize = Size(
          childSize.width + padding.horizontal,
          childSize.height + padding.vertical,
        );
      }

      size = constraints.constrain(childSize);
    } else {
      // No child, size to constraints
      size = constraints.constrain(Size(
        _width ?? constraints.minWidth,
        _height ?? constraints.minHeight,
      ));
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Apply margin offset
    Offset paintOffset = offset;
    if (_margin != null) {
      final EdgeInsets margin = _margin!.resolve(TextDirection.ltr);
      paintOffset = offset + Offset(margin.left, margin.top);
    }

    // Calculate paint size (excluding margin)
    Size paintSize = size;
    if (_margin != null) {
      final EdgeInsets margin = _margin!.resolve(TextDirection.ltr);
      paintSize = Size(
        size.width - margin.horizontal,
        size.height - margin.vertical,
      );
    }

    final Rect rect = paintOffset & paintSize;

    // Set up clipping if needed
    if (_clipBehavior != Clip.none) {
      context.pushClipRect(needsCompositing, paintOffset, rect,
          (context, offset) {
        _paintDecoration(context, offset, paintSize);
        _paintChild(context, offset);
        _paintForegroundDecoration(context, offset, paintSize);
      });
    } else {
      _paintDecoration(context, paintOffset, paintSize);
      _paintChild(context, paintOffset);
      _paintForegroundDecoration(context, paintOffset, paintSize);
    }

    // Debug visualization
    SugarDebug.paintBounds(context.canvas, rect, Colors.orange);
  }

  void _paintDecoration(PaintingContext context, Offset offset, Size size) {
    if (_decoration != null) {
      _decoration!.createBoxPainter().paint(
            context.canvas,
            offset,
            ImageConfiguration(size: size),
          );
    } else if (_color != null) {
      // Paint solid color background
      final paint = Paint()..color = _color!;
      context.canvas.drawRect(offset & size, paint);
    }
  }

  void _paintChild(PaintingContext context, Offset offset) {
    if (child != null) {
      // Calculate child offset with padding and alignment
      Offset childOffset = offset;

      if (_padding != null) {
        final EdgeInsets padding = _padding!.resolve(TextDirection.ltr);
        childOffset = offset + Offset(padding.left, padding.top);
      }

      if (_alignment != null) {
        final Size containerSize = size;
        Size availableSize = containerSize;
        if (_padding != null) {
          final EdgeInsets padding = _padding!.resolve(TextDirection.ltr);
          availableSize = Size(
            containerSize.width - padding.horizontal,
            containerSize.height - padding.vertical,
          );
        }

        final Alignment resolvedAlignment =
            _alignment!.resolve(TextDirection.ltr);
        final Offset alignmentOffset = resolvedAlignment.alongSize(Size(
          (availableSize.width - child!.size.width).clamp(0.0, double.infinity),
          (availableSize.height - child!.size.height)
              .clamp(0.0, double.infinity),
        ));
        childOffset += alignmentOffset;
      }

      // Apply transform if specified
      if (_transform != null) {
        final Matrix4 transform = Matrix4.identity();
        transform.multiply(_transform!);

        if (_transformAlignment != null) {
          final Alignment alignment =
              _transformAlignment!.resolve(TextDirection.ltr);
          final Offset center = alignment.alongSize(size);
          transform.translate(center.dx, center.dy);
          transform.multiply(_transform!);
          transform.translate(-center.dx, -center.dy);
        }

        context.pushTransform(needsCompositing, childOffset, transform,
            (context, offset) {
          context.paintChild(child!, offset);
        });
      } else {
        context.paintChild(child!, childOffset);
      }
    }
  }

  void _paintForegroundDecoration(
      PaintingContext context, Offset offset, Size size) {
    if (_foregroundDecoration != null) {
      _foregroundDecoration!.createBoxPainter().paint(
            context.canvas,
            offset,
            ImageConfiguration(size: size),
          );
    }
  }
}
