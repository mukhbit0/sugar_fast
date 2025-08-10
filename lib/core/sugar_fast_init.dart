import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sugar_observer.dart';

/// Main Sugar Fast initialization and configuration
class SugarFast {
  static SugarObserver? _observer;
  static bool _isInitialized = false;
  static bool _showDevPanel = false;

  /// Initialize Sugar Fast with default settings
  static void init({
    bool enableDevPanel = true,
    bool enableInDebugModeOnly = true,
  }) {
    if (_isInitialized) {
      debugPrint('Sugar Fast: Already initialized');
      return;
    }

    // Only enable in debug mode if specified
    if (enableInDebugModeOnly && !kDebugMode) {
      debugPrint('Sugar Fast: Skipping initialization (not in debug mode)');
      return;
    }

    _observer = SugarObserver();
    _showDevPanel = enableDevPanel;
    _isInitialized = true;

    debugPrint('Sugar Fast: Initialized successfully');
    debugPrint('Sugar Fast: Dev Panel enabled: $_showDevPanel');
  }

  /// Get the Sugar observer instance
  static SugarObserver? get observer => _observer;

  /// Whether Sugar Fast is initialized
  static bool get isInitialized => _isInitialized;

  /// Whether the dev panel should be shown
  static bool get showDevPanel => _showDevPanel && kDebugMode;

  /// Enable or disable the dev panel
  static void setDevPanelEnabled(bool enabled) {
    _showDevPanel = enabled;
  }

  /// Create a ProviderScope with Sugar Fast observer
  static ProviderScope createProviderScope({
    required Widget child,
    List<Override> overrides = const [],
    List<ProviderObserver> additionalObservers = const [],
  }) {
    if (!_isInitialized) {
      throw StateError(
        'Sugar Fast not initialized. Call SugarFast.init() first.',
      );
    }

    final observers = <ProviderObserver>[
      if (_observer != null) _observer!,
      ...additionalObservers,
    ];

    return ProviderScope(
      observers: observers,
      overrides: overrides,
      child: child,
    );
  }

  /// Dispose Sugar Fast (mainly for testing)
  static void dispose() {
    _observer?.clear();
    _observer = null;
    _isInitialized = false;
    _showDevPanel = false;
  }
}

/// Convenience widget that automatically sets up Sugar Fast
class SugarApp extends StatelessWidget {
  final Widget child;
  final List<Override> overrides;
  final List<ProviderObserver> additionalObservers;
  final bool enableDevPanel;
  final bool autoInit;

  const SugarApp({
    super.key,
    required this.child,
    this.overrides = const [],
    this.additionalObservers = const [],
    this.enableDevPanel = true,
    this.autoInit = true,
  });

  @override
  Widget build(BuildContext context) {
    if (autoInit && !SugarFast.isInitialized) {
      SugarFast.init(enableDevPanel: enableDevPanel);
    }

    return SugarFast.createProviderScope(
      overrides: overrides,
      additionalObservers: additionalObservers,
      child: child,
    );
  }
}
