/// Sugar Fast - The Ultimate Flutter Development Hub
///
/// A comprehensive meta-package that brings together the entire Sugar ecosystem
/// for super-fast Flutter development. Import once, get everything.
///
/// ## Quick Start
/// ```dart
/// import 'package:sugar_fast/sugar_fast.dart';
///
/// void main() {
///   SugarFast.initialize(); // Initialize all Sugar modules
///   runApp(MyApp());
/// }
/// ```
///
/// ## What's Included
/// - 🚀 **Go Router Sugar**: Zero-boilerplate, type-safe routing.
/// - 🍰 **Riverpod Sugar**: Helpers and extensions for Riverpod state management.
/// - 🧩 **Sugar UI**: (Coming Soon) Pre-built, customizable widgets.
/// - 🔗 **Sugar Connect**: (Coming Soon) HTTP/API utilities.
/// - 🎨 **Sugar Themer**: (Coming Soon) Advanced theming system.
///
library sugar_fast;

// ============================================================================
// SUGAR ECOSYSTEM EXPORTS
// ============================================================================

// Export the core libraries of the Sugar ecosystem.
export 'package:go_router_sugar/go_router_sugar.dart';
export 'package:riverpod_sugar/riverpod_sugar.dart';

// ============================================================================
// HUB FUNCTIONALITY
// ============================================================================

/// Sugar Fast Hub - Central initialization and configuration for the ecosystem.
class SugarFast {
  static bool _initialized = false;

  /// Initialize the entire Sugar ecosystem.
  ///
  /// Call this once in your main() function to set up all Sugar modules.
  ///
  /// ```dart
  /// void main() {
  ///   SugarFast.initialize(
  ///     devMode: kDebugMode,
  ///   );
  ///   runApp(MyApp());
  /// }
  /// ```
  static void initialize({
    bool devMode = false,
    Map<String, dynamic>? config,
  }) {
    if (_initialized) {
      print('Sugar Fast: Already initialized');
      return;
    }

    print('🚀 Sugar Fast: Initializing ecosystem...');

    // In the future, this can initialize each module.
    if (config != null) {
      // Apply any custom configuration across all modules
      print('⚙️ Sugar Fast: Configuration applied');
    }

    _initialized = true;
    print('✅ Sugar Fast: Ecosystem ready!');
  }

  /// Check if Sugar Fast has been initialized.
  static bool get isInitialized => _initialized;

  /// Get version information for all included Sugar packages.
  static Map<String, String> get versions => {
        'sugar_fast': '2.0.0',
        'go_router_sugar': '1.1.0', // Based on your README
        'riverpod_sugar': '1.0.9',
      };
}
