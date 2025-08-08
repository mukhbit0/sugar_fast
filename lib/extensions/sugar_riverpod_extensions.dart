import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sugar/riverpod_sugar.dart';
import '../widgets/sugar_text/sugar_text.dart';
import '../widgets/sugar_container/sugar_container.dart';
import '../widgets/sugar_icon/sugar_icon.dart';

/// Extensions that bridge Riverpod Sugar providers with Sugar widgets
extension SugarTextProviderExtensions on StateProvider<String> {
  /// Creates a SugarText widget that automatically watches this string provider
  Widget sugarText({
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final text = ref.watch(this);
        return SugarText(
          text,
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          textScaler: textScaler,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        );
      },
    );
  }
}

extension SugarColorProviderExtensions on StateProvider<Color> {
  /// Creates a SugarContainer with this color provider
  Widget sugarContainer({
    Key? key,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    Widget? child,
    Clip clipBehavior = Clip.none,
  }) {
    return Consumer(
      builder: (context, ref, _) {
        final color = ref.watch(this);
        return SugarContainer(
          key: key,
          alignment: alignment,
          padding: padding,
          // Use decoration if provided, otherwise use color
          color: decoration == null ? color : null,
          decoration: decoration ?? BoxDecoration(color: color),
          foregroundDecoration: foregroundDecoration,
          width: width,
          height: height,
          constraints: constraints,
          margin: margin,
          transform: transform,
          transformAlignment: transformAlignment,
          clipBehavior: clipBehavior,
          child: child,
        );
      },
    );
  }
}

extension SugarIconDataProviderExtensions on StateProvider<IconData> {
  /// Creates a SugarIcon that watches this IconData provider
  Widget sugarIcon({
    Key? key,
    double size = 24.0,
    Color color = Colors.black,
    String? semanticLabel,
    TextDirection? textDirection,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final iconData = ref.watch(this);
        return SugarIcon(
          iconData,
          key: key,
          size: size,
          color: color,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );
      },
    );
  }
}

/// Extensions on WidgetRef for building Sugar widgets from providers
extension SugarWidgetRefExtensions on WidgetRef {
  /// Build a SugarText from a string provider
  Widget sugarText(
    ProviderListenable<String> textProvider, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    final text = watch(textProvider);
    return SugarText(
      text,
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  /// Build a SugarContainer from a color provider
  Widget sugarContainer(
    ProviderListenable<Color> colorProvider, {
    Key? key,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    Widget? child,
    Clip clipBehavior = Clip.none,
  }) {
    final color = watch(colorProvider);
    return SugarContainer(
      key: key,
      alignment: alignment,
      padding: padding,
      // Use decoration if provided, otherwise use color
      color: decoration == null ? color : null,
      decoration: decoration ?? BoxDecoration(color: color),
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      child: child,
    );
  }

  /// Build a SugarIcon from an IconData provider
  Widget sugarIcon(
    ProviderListenable<IconData> iconProvider, {
    Key? key,
    double size = 24.0,
    Color color = Colors.black,
    String? semanticLabel,
    TextDirection? textDirection,
  }) {
    final iconData = watch(iconProvider);
    return SugarIcon(
      iconData,
      key: key,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}
