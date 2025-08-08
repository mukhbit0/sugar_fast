import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../core/sugar_debug.dart';

/// A list item widget that uses direct painting for optimal performance.
/// Feature-complete replacement for ListTile widget.
class SugarListItem extends StatefulWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool isThreeLine;
  final bool? dense;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final MouseCursor? mouseCursor;
  final bool selected;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? selectedColor;
  final Color? selectedTileColor;
  final VisualDensity? visualDensity;
  final ShapeBorder? shape;
  final bool autofocus;

  const SugarListItem({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.selectedColor,
    this.selectedTileColor,
    this.visualDensity,
    this.shape,
    this.autofocus = false,
  });

  @override
  State<SugarListItem> createState() => _SugarListItemState();
}

class _SugarListItemState extends State<SugarListItem> {
  bool _hovering = false;
  bool _pressing = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: widget.mouseCursor ?? SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressing = true),
        onTapUp: (_) => setState(() => _pressing = false),
        onTapCancel: () => setState(() => _pressing = false),
        onTap: widget.enabled ? widget.onTap : null,
        onLongPress: widget.enabled ? widget.onLongPress : null,
        child: _SugarListItemRenderer(
          leading: widget.leading,
          title: widget.title,
          subtitle: widget.subtitle,
          trailing: widget.trailing,
          isThreeLine: widget.isThreeLine,
          dense: widget.dense,
          contentPadding: widget.contentPadding,
          enabled: widget.enabled,
          selected: widget.selected,
          hovering: _hovering,
          pressing: _pressing,
          focusColor: widget.focusColor,
          hoverColor: widget.hoverColor,
          splashColor: widget.splashColor,
          selectedColor: widget.selectedColor,
          selectedTileColor: widget.selectedTileColor,
          visualDensity: widget.visualDensity,
          shape: widget.shape,
        ),
      ),
    );
  }
}

class _SugarListItemRenderer extends MultiChildRenderObjectWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool isThreeLine;
  final bool? dense;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final bool selected;
  final bool hovering;
  final bool pressing;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? selectedColor;
  final Color? selectedTileColor;
  final VisualDensity? visualDensity;
  final ShapeBorder? shape;

  const _SugarListItemRenderer({
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    required this.isThreeLine,
    this.dense,
    this.contentPadding,
    required this.enabled,
    required this.selected,
    required this.hovering,
    required this.pressing,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.selectedColor,
    this.selectedTileColor,
    this.visualDensity,
    this.shape,
  });

  @override
  List<Widget> get children {
    final List<Widget> children = [];
    if (leading != null) children.add(leading!);
    if (title != null) children.add(title!);
    if (subtitle != null) children.add(subtitle!);
    if (trailing != null) children.add(trailing!);
    return children;
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SugarListItemRenderBox(
      isThreeLine: isThreeLine,
      dense: dense,
      contentPadding: contentPadding,
      enabled: enabled,
      selected: selected,
      hovering: hovering,
      pressing: pressing,
      focusColor: focusColor,
      hoverColor: hoverColor,
      splashColor: splashColor,
      selectedColor: selectedColor,
      selectedTileColor: selectedTileColor,
      visualDensity: visualDensity,
      shape: shape,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _SugarListItemRenderBox renderObject) {
    renderObject
      ..isThreeLine = isThreeLine
      ..dense = dense
      ..contentPadding = contentPadding
      ..enabled = enabled
      ..selected = selected
      ..hovering = hovering
      ..pressing = pressing
      ..focusColor = focusColor
      ..hoverColor = hoverColor
      ..splashColor = splashColor
      ..selectedColor = selectedColor
      ..selectedTileColor = selectedTileColor
      ..visualDensity = visualDensity
      ..shape = shape;
  }
}

class _SugarListItemRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ListItemParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ListItemParentData> {
  bool _isThreeLine;
  bool? _dense;
  EdgeInsetsGeometry? _contentPadding;
  bool _enabled;
  bool _selected;
  bool _hovering;
  bool _pressing;
  Color? _focusColor;
  Color? _hoverColor;
  Color? _splashColor;
  Color? _selectedColor;
  Color? _selectedTileColor;
  VisualDensity? _visualDensity;
  ShapeBorder? _shape;

  _SugarListItemRenderBox({
    required bool isThreeLine,
    bool? dense,
    EdgeInsetsGeometry? contentPadding,
    required bool enabled,
    required bool selected,
    required bool hovering,
    required bool pressing,
    Color? focusColor,
    Color? hoverColor,
    Color? splashColor,
    Color? selectedColor,
    Color? selectedTileColor,
    VisualDensity? visualDensity,
    ShapeBorder? shape,
  })  : _isThreeLine = isThreeLine,
        _dense = dense,
        _contentPadding = contentPadding,
        _enabled = enabled,
        _selected = selected,
        _hovering = hovering,
        _pressing = pressing,
        _focusColor = focusColor,
        _hoverColor = hoverColor,
        _splashColor = splashColor,
        _selectedColor = selectedColor,
        _selectedTileColor = selectedTileColor,
        _visualDensity = visualDensity,
        _shape = shape;

  // Getters and setters
  bool get isThreeLine => _isThreeLine;
  set isThreeLine(bool value) {
    if (_isThreeLine != value) {
      _isThreeLine = value;
      markNeedsLayout();
    }
  }

  bool? get dense => _dense;
  set dense(bool? value) {
    if (_dense != value) {
      _dense = value;
      markNeedsLayout();
    }
  }

  EdgeInsetsGeometry? get contentPadding => _contentPadding;
  set contentPadding(EdgeInsetsGeometry? value) {
    if (_contentPadding != value) {
      _contentPadding = value;
      markNeedsLayout();
    }
  }

  bool get enabled => _enabled;
  set enabled(bool value) {
    if (_enabled != value) {
      _enabled = value;
      markNeedsPaint();
    }
  }

  bool get selected => _selected;
  set selected(bool value) {
    if (_selected != value) {
      _selected = value;
      markNeedsPaint();
    }
  }

  bool get hovering => _hovering;
  set hovering(bool value) {
    if (_hovering != value) {
      _hovering = value;
      markNeedsPaint();
    }
  }

  bool get pressing => _pressing;
  set pressing(bool value) {
    if (_pressing != value) {
      _pressing = value;
      markNeedsPaint();
    }
  }

  Color? get focusColor => _focusColor;
  set focusColor(Color? value) {
    if (_focusColor != value) {
      _focusColor = value;
      markNeedsPaint();
    }
  }

  Color? get hoverColor => _hoverColor;
  set hoverColor(Color? value) {
    if (_hoverColor != value) {
      _hoverColor = value;
      markNeedsPaint();
    }
  }

  Color? get splashColor => _splashColor;
  set splashColor(Color? value) {
    if (_splashColor != value) {
      _splashColor = value;
      markNeedsPaint();
    }
  }

  Color? get selectedColor => _selectedColor;
  set selectedColor(Color? value) {
    if (_selectedColor != value) {
      _selectedColor = value;
      markNeedsPaint();
    }
  }

  Color? get selectedTileColor => _selectedTileColor;
  set selectedTileColor(Color? value) {
    if (_selectedTileColor != value) {
      _selectedTileColor = value;
      markNeedsPaint();
    }
  }

  VisualDensity? get visualDensity => _visualDensity;
  set visualDensity(VisualDensity? value) {
    if (_visualDensity != value) {
      _visualDensity = value;
      markNeedsLayout();
    }
  }

  ShapeBorder? get shape => _shape;
  set shape(ShapeBorder? value) {
    if (_shape != value) {
      _shape = value;
      markNeedsPaint();
    }
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _ListItemParentData) {
      child.parentData = _ListItemParentData();
    }
  }

  @override
  void performLayout() {
    final EdgeInsets padding =
        (_contentPadding ?? EdgeInsets.zero).resolve(TextDirection.ltr);
    final availableWidth = constraints.maxWidth - padding.horizontal;

    double height = _dense == true ? 48.0 : 56.0;
    if (_isThreeLine) height = _dense == true ? 64.0 : 72.0;

    // Layout children (simplified layout logic)
    RenderBox? child = firstChild;
    int childIndex = 0;

    while (child != null) {
      final _ListItemParentData childParentData =
          child.parentData! as _ListItemParentData;

      if (childIndex == 0) {
        // leading
        child.layout(BoxConstraints.loose(Size(56, height)),
            parentUsesSize: true);
        childParentData.offset = Offset(padding.left, padding.top);
      } else if (childIndex == 1) {
        // title
        final leadingWidth = firstChild?.size.width ?? 0;
        child.layout(
            BoxConstraints.loose(
                Size(availableWidth - leadingWidth - 56, height)),
            parentUsesSize: true);
        childParentData.offset =
            Offset(padding.left + leadingWidth + 8, padding.top);
      } else if (childIndex == 2) {
        // subtitle
        final leadingWidth = firstChild?.size.width ?? 0;
        child.layout(
            BoxConstraints.loose(
                Size(availableWidth - leadingWidth - 56, height)),
            parentUsesSize: true);
        childParentData.offset =
            Offset(padding.left + leadingWidth + 8, padding.top + 20);
      } else if (childIndex == 3) {
        // trailing
        child.layout(BoxConstraints.loose(Size(56, height)),
            parentUsesSize: true);
        childParentData.offset = Offset(
            constraints.maxWidth - padding.right - child.size.width,
            padding.top);
      }

      child = childParentData.nextSibling;
      childIndex++;
    }

    size = constraints
        .constrain(Size(constraints.maxWidth, height + padding.vertical));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Paint background
    Color? backgroundColor;
    if (_selected && _selectedTileColor != null) {
      backgroundColor = _selectedTileColor;
    } else if (_hovering && _hoverColor != null) {
      backgroundColor = _hoverColor;
    } else if (_pressing && _splashColor != null) {
      backgroundColor = _splashColor;
    }

    if (backgroundColor != null) {
      final paint = Paint()..color = backgroundColor;
      final rect = offset & size;

      if (_shape != null) {
        final path = _shape!.getOuterPath(rect);
        context.canvas.drawPath(path, paint);
      } else {
        context.canvas.drawRect(rect, paint);
      }
    }

    // Paint children
    RenderBox? child = firstChild;
    while (child != null) {
      final _ListItemParentData childParentData =
          child.parentData! as _ListItemParentData;
      context.paintChild(child, offset + childParentData.offset);
      child = childParentData.nextSibling;
    }

    // Debug visualization
    SugarDebug.paintBounds(
      context.canvas,
      Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
      Colors.green,
    );
  }
}

class _ListItemParentData extends ContainerBoxParentData<RenderBox> {}
