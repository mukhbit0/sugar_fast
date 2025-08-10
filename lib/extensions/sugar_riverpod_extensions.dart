import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sugar/riverpod_sugar.dart';
import '../core/sugar_observer.dart';
import '../core/sugar_state_manager.dart';

/// Extensions that add Sugar Fast debugging capabilities to Riverpod providers
extension SugarProviderDebugging<T> on StateProvider<T> {
  /// Get the current value being tracked by Sugar Fast
  T? get debugValue {
    final observer = SugarObserver();
    return observer.getState(toString()) as T?;
  }

  /// Set the value through Sugar Fast (for debugging)
  bool debugSetValue(T newValue, WidgetRef ref) {
    final observer = SugarObserver();
    return observer.setState(toString(), newValue, ref);
  }

  /// Get the provider name as tracked by Sugar Fast
  String get debugName {
    return name ?? runtimeType.toString();
  }

  /// Check if this provider is currently being tracked
  bool get isTracked {
    final observer = SugarObserver();
    return observer.stateMap.containsKey(debugName);
  }
}

/// Extensions for debugging state changes and history
extension SugarStateHistory on WidgetRef {
  /// Get the state history for a specific provider
  List<StateSnapshot> getProviderHistory(String providerName) {
    return SugarStateManager.getStateHistory()
        .where((snapshot) => snapshot.providerName == providerName)
        .toList();
  }

  /// Get all providers of a specific type
  List<String> getProvidersOfType<T>() {
    return SugarStateManager.findProvidersByType<T>();
  }

  /// Create a state scenario with current values
  StateScenario createDebugScenario(String name, {String? description}) {
    return SugarStateManager.createScenario(name, description: description);
  }

  /// Apply a state scenario
  bool applyDebugScenario(StateScenario scenario) {
    return SugarStateManager.applyScenario(scenario, this);
  }

  /// Get a summary of all tracked state
  StateSummary getStateSummary() {
    return SugarStateManager.getStateSummary();
  }

  /// Find providers containing a specific value
  List<String> findProvidersWithValue(dynamic value) {
    return SugarStateManager.findProvidersContaining(value);
  }

  /// Export all current state as JSON
  String exportAllState() {
    return SugarStateManager.exportState();
  }

  /// Import state from JSON
  bool importState(String stateJson) {
    return SugarStateManager.importState(stateJson, this);
  }
}

/// Extensions for common debugging patterns
extension SugarDebugPatterns on WidgetRef {
  /// Quick debug: log current value of a provider
  void debugLog<T>(ProviderListenable<T> provider, [String? label]) {
    final value = read(provider);
    debugPrint('Sugar Fast Debug ${label ?? provider.toString()}: $value');
  }

  /// Quick debug: create a snapshot with current timestamp
  String debugSnapshot([String? label]) {
    final timestamp = DateTime.now().toIso8601String();
    final scenario = createDebugScenario(
      label ?? 'Debug Snapshot $timestamp',
      description: 'Created at $timestamp',
    );
    return scenario.stateData;
  }

  /// Quick debug: reset a StateProvider to its initial value
  void debugReset<T>(StateProvider<T> provider) {
    // This would require storing initial values, which is a future enhancement
    debugPrint('Sugar Fast: Reset functionality coming in future version');
  }
}

/// Utility extensions for Sugar Fast integration
extension SugarFastIntegration on ProviderContainer {
  /// Add Sugar Fast observer to an existing container
  void addSugarObserver() {
    // This would require modifying the container's observers
    // Currently observers can't be added to existing containers
    debugPrint('Sugar Fast: Use SugarFast.createProviderScope() for automatic setup');
  }
}

/// Extensions for StateNotifier debugging (future enhancement)
extension SugarStateNotifierDebugging<T> on StateNotifierProvider<dynamic, T> {
  /// Get the current state being tracked by Sugar Fast
  T? get debugValue {
    final observer = SugarObserver();
    return observer.getState(toString()) as T?;
  }

  /// Get the provider name as tracked by Sugar Fast
  String get debugName {
    return name ?? runtimeType.toString();
  }

  /// Check if this provider is currently being tracked
  bool get isTracked {
    final observer = SugarObserver();
    return observer.stateMap.containsKey(debugName);
  }
}
