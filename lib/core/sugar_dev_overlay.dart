import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sugar_dev_panel.dart';
import 'sugar_fast_init.dart';

/// Overlay widget that adds the Sugar Fast dev panel to your app
/// Place this inside your MaterialApp/WidgetsApp widget tree
class SugarDevOverlay extends StatelessWidget {
  final Widget child;

  const SugarDevOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Only show dev panel if Sugar Fast is initialized and enabled
    if (!SugarFast.isInitialized || !SugarFast.showDevPanel) {
      return child;
    }

    return Stack(
      alignment: Alignment.topLeft, // Use explicit alignment instead of directional
      children: [
        child,
        const SugarDevPanel(),
      ],
    );
  }
}

/// Enhanced MaterialApp that automatically includes Sugar Fast dev panel
class SugarMaterialApp extends ConsumerWidget {
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final AnimationStyle? themeAnimationStyle;

  const SugarMaterialApp({
    super.key,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.home,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.themeAnimationStyle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorObservers: navigatorObservers,
      home: home,
      routes: routes ?? const {},
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      builder: (context, child) {
        Widget result = child ?? const SizedBox.shrink();
        
        // Apply custom builder if provided
        if (builder != null) {
          result = builder!(context, result);
        }
        
        // Add Sugar Fast dev overlay
        result = SugarDevOverlay(child: result);
        
        return result;
      },
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      debugShowMaterialGrid: debugShowMaterialGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior,
      themeAnimationStyle: themeAnimationStyle,
    );
  }
}
