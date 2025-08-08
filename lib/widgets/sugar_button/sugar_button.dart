import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../core/sugar_debug.dart';

/// A button widget that uses direct painting for optimal performance.
/// Feature-complete replacement for ElevatedButton/TextButton widgets.
class SugarButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool autofocus;
  final Clip clipBehavior;
  final WidgetStatesController? statesController;

  const SugarButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
  });

  @override
  State<SugarButton> createState() => _SugarButtonState();
}

class _SugarButtonState extends State<SugarButton> {
  late WidgetStatesController _statesController;
  bool _hovering = false;
  bool _pressing = false;

  @override
  void initState() {
    super.initState();
    _statesController = widget.statesController ?? WidgetStatesController();
  }

  @override
  void dispose() {
    if (widget.statesController == null) {
      _statesController.dispose();
    }
    super.dispose();
  }

  void _updateStates() {
    final Set<WidgetState> states = <WidgetState>{};
    if (widget.onPressed == null) {
      states.add(WidgetState.disabled);
    }
    if (_hovering) {
      states.add(WidgetState.hovered);
    }
    if (_pressing) {
      states.add(WidgetState.pressed);
    }
    _statesController.value = states;
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle? style = widget.style ?? ElevatedButton.styleFrom();

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovering = true;
          _updateStates();
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
          _updateStates();
        });
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _pressing = true;
            _updateStates();
          });
        },
        onTapUp: (_) {
          setState(() {
            _pressing = false;
            _updateStates();
          });
        },
        onTapCancel: () {
          setState(() {
            _pressing = false;
            _updateStates();
          });
        },
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _statesController,
          builder: (context, child) {
            return _SugarButtonRenderer(
              style: style,
              states: _statesController.value,
              clipBehavior: widget.clipBehavior,
              child: widget.child,
            );
          },
        ),
      ),
    );
  }
}

class _SugarButtonRenderer extends SingleChildRenderObjectWidget {
  final ButtonStyle? style;
  final Set<WidgetState> states;
  final Clip clipBehavior;

  const _SugarButtonRenderer({
    required this.style,
    required this.states,
    required this.clipBehavior,
    required Widget child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SugarButtonRenderBox(
      style: style,
      states: states,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _SugarButtonRenderBox renderObject) {
    renderObject
      ..style = style
      ..states = states
      ..clipBehavior = clipBehavior;
  }
}

class _SugarButtonRenderBox extends RenderProxyBox {
  ButtonStyle? _style;
  Set<WidgetState> _states;
  Clip _clipBehavior;

  _SugarButtonRenderBox({
    ButtonStyle? style,
    required Set<WidgetState> states,
    required Clip clipBehavior,
  })  : _style = style,
        _states = states,
        _clipBehavior = clipBehavior;

  ButtonStyle? get style => _style;
  set style(ButtonStyle? value) {
    if (_style != value) {
      _style = value;
      markNeedsPaint();
    }
  }

  Set<WidgetState> get states => _states;
  set states(Set<WidgetState> value) {
    if (_states != value) {
      _states = value;
      markNeedsPaint();
    }
  }

  Clip get clipBehavior => _clipBehavior;
  set clipBehavior(Clip value) {
    if (_clipBehavior != value) {
      _clipBehavior = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = child!.size;
    } else {
      size = constraints.smallest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_style != null) {
      // Paint background
      final backgroundColor = _style!.backgroundColor?.resolve(_states);
      if (backgroundColor != null) {
        final paint = Paint()..color = backgroundColor;
        final borderRadius = _style!.shape?.resolve(_states);

        if (borderRadius is RoundedRectangleBorder &&
            borderRadius.borderRadius != BorderRadius.zero) {
          final resolvedRadius =
              borderRadius.borderRadius.resolve(TextDirection.ltr);
          final rrect = RRect.fromRectAndCorners(
            offset & size,
            topLeft: resolvedRadius.topLeft,
            topRight: resolvedRadius.topRight,
            bottomLeft: resolvedRadius.bottomLeft,
            bottomRight: resolvedRadius.bottomRight,
          );
          context.canvas.drawRRect(rrect, paint);
        } else {
          context.canvas.drawRect(offset & size, paint);
        }
      }

      // Paint border
      final borderSide = _style!.side?.resolve(_states);
      if (borderSide != null && borderSide.width > 0) {
        final paint = Paint()
          ..color = borderSide.color
          ..strokeWidth = borderSide.width
          ..style = PaintingStyle.stroke;

        final borderRadius = _style!.shape?.resolve(_states);
        if (borderRadius is RoundedRectangleBorder &&
            borderRadius.borderRadius != BorderRadius.zero) {
          final resolvedRadius =
              borderRadius.borderRadius.resolve(TextDirection.ltr);
          final rrect = RRect.fromRectAndCorners(
            offset & size,
            topLeft: resolvedRadius.topLeft,
            topRight: resolvedRadius.topRight,
            bottomLeft: resolvedRadius.bottomLeft,
            bottomRight: resolvedRadius.bottomRight,
          );
          context.canvas.drawRRect(rrect, paint);
        } else {
          context.canvas.drawRect(offset & size, paint);
        }
      }
    }

    // Paint child
    if (child != null) {
      context.paintChild(child!, offset);
    }

    // Debug visualization
    SugarDebug.paintBounds(
      context.canvas,
      Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
      Colors.purple,
    );
  }
}
