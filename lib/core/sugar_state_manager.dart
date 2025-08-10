import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sugar_observer.dart';

/// Advanced state management utilities for Sugar Fast
class SugarStateManager {
  static SugarObserver get _observer {
    return SugarObserver();
  }

  /// Export all current state as JSON
  static String exportState() {
    return _observer.saveSnapshot();
  }

  /// Import state from JSON and apply it
  static bool importState(String stateJson, WidgetRef ref) {
    return _observer.loadSnapshot(stateJson, ref);
  }

  /// Get a list of all provider names
  static List<String> getProviderNames() {
    return _observer.stateMap.keys.toList();
  }

  /// Get state value for a specific provider
  static T? getProviderState<T>(String providerName) {
    final value = _observer.getState(providerName);
    if (value is T) return value;
    return null;
  }

  /// Set state for a specific provider
  static bool setProviderState(String providerName, dynamic value, WidgetRef ref) {
    return _observer.setState(providerName, value, ref);
  }

  /// Get state history for debugging
  static List<StateSnapshot> getStateHistory() {
    return _observer.stateHistory.toList();
  }

  /// Create a state scenario (named snapshot)
  static StateScenario createScenario(String name, {String? description}) {
    return StateScenario(
      name: name,
      description: description,
      timestamp: DateTime.now(),
      stateData: _observer.saveSnapshot(),
    );
  }

  /// Apply a state scenario
  static bool applyScenario(StateScenario scenario, WidgetRef ref) {
    return _observer.loadSnapshot(scenario.stateData, ref);
  }

  /// Get a summary of current state
  static StateSummary getStateSummary() {
    final stateMap = _observer.stateMap;
    final providerCount = stateMap.length;
    final typeCount = <String, int>{};
    
    for (final value in stateMap.values) {
      final type = value.runtimeType.toString();
      typeCount[type] = (typeCount[type] ?? 0) + 1;
    }

    return StateSummary(
      providerCount: providerCount,
      typeDistribution: typeCount,
      totalHistoryEntries: _observer.stateHistory.length,
      lastUpdateTime: _observer.stateHistory.isNotEmpty 
          ? _observer.stateHistory.last.timestamp 
          : null,
    );
  }

  /// Find providers by value type
  static List<String> findProvidersByType<T>() {
    return _observer.stateMap.entries
        .where((entry) => entry.value is T)
        .map((entry) => entry.key)
        .toList();
  }

  /// Find providers containing specific value
  static List<String> findProvidersContaining(dynamic searchValue) {
    return _observer.stateMap.entries
        .where((entry) => _containsValue(entry.value, searchValue))
        .map((entry) => entry.key)
        .toList();
  }

  static bool _containsValue(dynamic value, dynamic searchValue) {
    if (value == searchValue) return true;
    
    if (value is Map) {
      return value.values.any((v) => _containsValue(v, searchValue));
    }
    
    if (value is List) {
      return value.any((v) => _containsValue(v, searchValue));
    }
    
    if (value is String && searchValue is String) {
      return value.toLowerCase().contains(searchValue.toLowerCase());
    }
    
    return false;
  }

  /// Watch for changes to specific providers
  static void watchProviders(List<String> providerNames, Function(String, dynamic) onChanged) {
    // This would require extending SugarObserver to support callbacks
    // For now, this is a placeholder for future implementation
    if (kDebugMode) {
      print('Sugar Fast: Provider watching not yet implemented');
    }
  }

  /// Validate state integrity
  static List<String> validateState() {
    final issues = <String>[];
    
    for (final entry in _observer.stateMap.entries) {
      try {
        // Try to serialize the value to check if it's valid
        jsonEncode(entry.value);
      } catch (e) {
        issues.add('Provider ${entry.key} has non-serializable state: $e');
      }
    }
    
    return issues;
  }
}

/// Represents a named state scenario for testing
class StateScenario {
  final String name;
  final String? description;
  final DateTime timestamp;
  final String stateData;

  const StateScenario({
    required this.name,
    this.description,
    required this.timestamp,
    required this.stateData,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'timestamp': timestamp.toIso8601String(),
    'stateData': stateData,
  };

  factory StateScenario.fromJson(Map<String, dynamic> json) => StateScenario(
    name: json['name'] as String,
    description: json['description'] as String?,
    timestamp: DateTime.parse(json['timestamp'] as String),
    stateData: json['stateData'] as String,
  );

  @override
  String toString() => 'StateScenario($name, ${timestamp.toIso8601String()})';
}

/// Summary of current state for analytics
class StateSummary {
  final int providerCount;
  final Map<String, int> typeDistribution;
  final int totalHistoryEntries;
  final DateTime? lastUpdateTime;

  const StateSummary({
    required this.providerCount,
    required this.typeDistribution,
    required this.totalHistoryEntries,
    this.lastUpdateTime,
  });

  @override
  String toString() {
    return 'StateSummary('
        'providers: $providerCount, '
        'types: ${typeDistribution.keys.length}, '
        'history: $totalHistoryEntries, '
        'lastUpdate: $lastUpdateTime'
        ')';
  }
}
