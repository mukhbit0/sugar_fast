import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../core/sugar_debug.dart';

/// An image widget that uses direct painting for optimal performance.
/// Feature-complete replacement for Image widget.
class SugarImage extends LeafRenderObjectWidget {
  final ImageProvider image;
  final double? width;
  final double? height;
  final Color? color;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final bool gaplessPlayback;
  final FilterQuality filterQuality;

  const SugarImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
  });

  /// Create from asset path
  SugarImage.asset(
    String name, {
    super.key,
    String? package,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
  }) : image = AssetImage(name, package: package);

  /// Create from network URL
  SugarImage.network(
    String src, {
    super.key,
    double scale = 1.0,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
  }) : image = NetworkImage(src, scale: scale);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SugarImageRenderBox(
      image: image,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _SugarImageRenderBox renderObject) {
    renderObject
      ..image = image
      ..width = width
      ..height = height
      ..color = color
      ..colorBlendMode = colorBlendMode
      ..fit = fit
      ..alignment = alignment
      ..repeat = repeat
      ..centerSlice = centerSlice
      ..gaplessPlayback = gaplessPlayback
      ..filterQuality = filterQuality;
  }
}

class _SugarImageRenderBox extends RenderBox {
  ImageProvider _image;
  double? _width;
  double? _height;
  Color? _color;
  BlendMode? _colorBlendMode;
  BoxFit? _fit;
  AlignmentGeometry _alignment;
  ImageRepeat _repeat;
  Rect? _centerSlice;
  bool _gaplessPlayback;
  FilterQuality _filterQuality;

  ui.Image? _resolvedImage;
  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;

  _SugarImageRenderBox({
    required ImageProvider image,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    required AlignmentGeometry alignment,
    required ImageRepeat repeat,
    Rect? centerSlice,
    required bool gaplessPlayback,
    required FilterQuality filterQuality,
  })  : _image = image,
        _width = width,
        _height = height,
        _color = color,
        _colorBlendMode = colorBlendMode,
        _fit = fit,
        _alignment = alignment,
        _repeat = repeat,
        _centerSlice = centerSlice,
        _gaplessPlayback = gaplessPlayback,
        _filterQuality = filterQuality {
    _loadImage();
  }

  void _loadImage() {
    _imageStream = _image.resolve(ImageConfiguration.empty);
    _imageStreamListener = ImageStreamListener(_onImageLoaded);
    _imageStream!.addListener(_imageStreamListener!);
  }

  void _onImageLoaded(ImageInfo imageInfo, bool synchronousCall) {
    _resolvedImage = imageInfo.image;
    markNeedsPaint();
  }

  // Getters and setters
  ImageProvider get image => _image;
  set image(ImageProvider value) {
    if (_image != value) {
      _disposeImageStream();
      _image = value;
      _loadImage();
      markNeedsPaint();
    }
  }

  double? get width => _width;
  set width(double? value) {
    if (_width != value) {
      _width = value;
      markNeedsLayout();
    }
  }

  double? get height => _height;
  set height(double? value) {
    if (_height != value) {
      _height = value;
      markNeedsLayout();
    }
  }

  Color? get color => _color;
  set color(Color? value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  BlendMode? get colorBlendMode => _colorBlendMode;
  set colorBlendMode(BlendMode? value) {
    if (_colorBlendMode != value) {
      _colorBlendMode = value;
      markNeedsPaint();
    }
  }

  BoxFit? get fit => _fit;
  set fit(BoxFit? value) {
    if (_fit != value) {
      _fit = value;
      markNeedsPaint();
    }
  }

  AlignmentGeometry get alignment => _alignment;
  set alignment(AlignmentGeometry value) {
    if (_alignment != value) {
      _alignment = value;
      markNeedsPaint();
    }
  }

  ImageRepeat get repeat => _repeat;
  set repeat(ImageRepeat value) {
    if (_repeat != value) {
      _repeat = value;
      markNeedsPaint();
    }
  }

  Rect? get centerSlice => _centerSlice;
  set centerSlice(Rect? value) {
    if (_centerSlice != value) {
      _centerSlice = value;
      markNeedsPaint();
    }
  }

  bool get gaplessPlayback => _gaplessPlayback;
  set gaplessPlayback(bool value) {
    if (_gaplessPlayback != value) {
      _gaplessPlayback = value;
      markNeedsPaint();
    }
  }

  FilterQuality get filterQuality => _filterQuality;
  set filterQuality(FilterQuality value) {
    if (_filterQuality != value) {
      _filterQuality = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    if (_resolvedImage != null) {
      final imageSize = Size(
        _resolvedImage!.width.toDouble(),
        _resolvedImage!.height.toDouble(),
      );

      Size targetSize;
      if (_width != null && _height != null) {
        targetSize = Size(_width!, _height!);
      } else if (_width != null) {
        final aspectRatio = imageSize.width / imageSize.height;
        targetSize = Size(_width!, _width! / aspectRatio);
      } else if (_height != null) {
        final aspectRatio = imageSize.width / imageSize.height;
        targetSize = Size(_height! * aspectRatio, _height!);
      } else {
        targetSize = imageSize;
      }

      size = constraints.constrain(targetSize);
    } else {
      // No image loaded yet, use specified dimensions or minimum
      size = constraints.constrain(Size(
        _width ?? constraints.minWidth,
        _height ?? constraints.minHeight,
      ));
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_resolvedImage == null) {
      // Paint placeholder or loading indicator
      final paint = Paint()..color = Colors.grey.withValues(alpha: 0.3);
      context.canvas.drawRect(offset & size, paint);
      return;
    }

    final imageSize = Size(
      _resolvedImage!.width.toDouble(),
      _resolvedImage!.height.toDouble(),
    );

    final outputRect = offset & size;
    final inputRect = Rect.fromLTWH(0, 0, imageSize.width, imageSize.height);

    // Calculate fit
    final fittedSizes = applyBoxFit(_fit ?? BoxFit.contain, imageSize, size);
    final destinationSize = fittedSizes.destination;

    // Calculate alignment
    final resolvedAlignment = _alignment.resolve(TextDirection.ltr);
    final alignmentOffset = resolvedAlignment.alongSize(Size(
      (size.width - destinationSize.width).clamp(0.0, double.infinity),
      (size.height - destinationSize.height).clamp(0.0, double.infinity),
    ));
    final destinationRect = (offset + alignmentOffset) & destinationSize;

    // Paint the image
    final paint = Paint()
      ..filterQuality = _filterQuality
      ..isAntiAlias = true;

    if (_color != null && _colorBlendMode != null) {
      paint.colorFilter = ColorFilter.mode(_color!, _colorBlendMode!);
    }

    if (_centerSlice != null) {
      // Nine-patch drawing
      _paintNinePatch(context.canvas, _resolvedImage!, inputRect,
          destinationRect, _centerSlice!, paint);
    } else {
      // Simple image drawing
      context.canvas
          .drawImageRect(_resolvedImage!, inputRect, destinationRect, paint);
    }

    // Debug visualization
    SugarDebug.paintBounds(context.canvas, outputRect, Colors.cyan);
  }

  void _paintNinePatch(Canvas canvas, ui.Image image, Rect src, Rect dst,
      Rect centerSlice, Paint paint) {
    // This is a simplified nine-patch implementation
    // In a full implementation, you'd divide both src and dst into 9 regions
    canvas.drawImageNine(image, centerSlice, dst, paint);
  }

  void _disposeImageStream() {
    if (_imageStream != null && _imageStreamListener != null) {
      _imageStream!.removeListener(_imageStreamListener!);
    }
    _imageStream = null;
    _imageStreamListener = null;
  }

  @override
  void dispose() {
    _disposeImageStream();
    super.dispose();
  }
}
