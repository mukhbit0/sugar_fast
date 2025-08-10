import 'dart:convert';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Core observer that tracks all Riverpod state changes for live editing
class SugarObserver extends ProviderObserver {
  static final SugarObserver _instance = SugarObserver._internal();
  
  factory SugarObserver() => _instance;
  
  SugarObserver._internal();

  /// Map of provider names to their current state values
  final Map<String, dynamic> _stateMap = {};
  
  /// Map of provider names to their actual provider references
  final Map<String, ProviderBase> _providerMap = {};
  
  /// History of state changes for time travel debugging
  final List<StateSnapshot> _stateHistory = [];
  
  /// Maximum number of snapshots to keep in history
  static const int maxHistorySize = 100;

  /// Get current state map (read-only view)
  UnmodifiableMapView<String, dynamic> get stateMap => 
      UnmodifiableMapView(_stateMap);

  /// Get state history (read-only view)
  UnmodifiableListView<StateSnapshot> get stateHistory => 
      UnmodifiableListView(_stateHistory);

  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    super.didAddProvider(provider, value, container);
    _trackProvider(provider, value);
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    _trackProvider(provider, newValue);
    
    // Add to history
    _addToHistory(provider, previousValue, newValue);
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    super.didDisposeProvider(provider, container);
    final providerName = _getProviderName(provider);
    _stateMap.remove(providerName);
    _providerMap.remove(providerName);
  }

  /// Track a provider's state
  void _trackProvider(ProviderBase provider, Object? value) {
    final providerName = _getProviderName(provider);
    _stateMap[providerName] = _serializableValue(value);
    _providerMap[providerName] = provider;
  }

  /// Add state change to history
  void _addToHistory(ProviderBase provider, Object? oldValue, Object? newValue) {
    final snapshot = StateSnapshot(
      providerName: _getProviderName(provider),
      timestamp: DateTime.now(),
      oldValue: _serializableValue(oldValue),
      newValue: _serializableValue(newValue),
    );
    
    _stateHistory.add(snapshot);
    
    // Keep history size manageable
    if (_stateHistory.length > maxHistorySize) {
      _stateHistory.removeAt(0);
    }
  }

  /// Get a human-readable name for a provider
  String _getProviderName(ProviderBase provider) {
    // Try to get the name from the provider
    final name = provider.name;
    if (name != null && name.isNotEmpty) {
      return name;
    }
    
    // Fall back to runtime type
    return provider.runtimeType.toString();
  }

  /// Convert a value to a serializable format
  dynamic _serializableValue(Object? value) {
    if (value == null) return null;
    
    // Handle common types
    if (value is String || value is num || value is bool) {
      return value;
    }
    
    // Handle lists and maps
    if (value is List) {
      return value.map(_serializableValue).toList();
    }
    
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), _serializableValue(v)));
    }
    
    // Handle AsyncValue
    if (value is AsyncValue) {
      return {
        'type': 'AsyncValue',
        'hasValue': value.hasValue,
        'hasError': value.hasError,
        'isLoading': value.isLoading,
        'value': value.hasValue ? _serializableValue(value.value) : null,
        'error': value.hasError ? value.error.toString() : null,
      };
    }
    
    // For custom objects, try to convert to string
    return value.toString();
  }

  /// Get current state value for a provider
  dynamic getState(String providerName) {
    return _stateMap[providerName];
  }

  /// Set state for a provider (if possible)
  bool setState(String providerName, dynamic newValue, WidgetRef ref) {
    try {
      final provider = _providerMap[providerName];
      if (provider == null) {
        debugPrint('Sugar Fast: Provider $providerName not found');
        return false;
      }

      // Handle different provider types
      if (provider is StateProvider) {
        ref.read(provider.notifier).state = newValue;
        return true;
      }
      
      if (provider is StateNotifierProvider) {
        // This is more complex as we need to know the StateNotifier's interface
        debugPrint('Sugar Fast: StateNotifierProvider editing not yet implemented');
        return false;
      }
      
      debugPrint('Sugar Fast: Cannot edit provider type: ${provider.runtimeType}');
      return false;
    } catch (e) {
      debugPrint('Sugar Fast: Error setting state for $providerName: $e');
      return false;
    }
  }

  /// Save current state as a snapshot
  String saveSnapshot() {
    final snapshot = {
      'timestamp': DateTime.now().toIso8601String(),
      'state': Map<String, dynamic>.from(_stateMap),
    };
    return jsonEncode(snapshot);
  }

  /// Load state from a snapshot
  bool loadSnapshot(String snapshotJson, WidgetRef ref) {
    try {
      final snapshot = jsonDecode(snapshotJson) as Map<String, dynamic>;
      final state = snapshot['state'] as Map<String, dynamic>;
      
      bool allSuccessful = true;
      for (final entry in state.entries) {
        if (!setState(entry.key, entry.value, ref)) {
          allSuccessful = false;
        }
      }
      
      return allSuccessful;
    } catch (e) {
      debugPrint('Sugar Fast: Error loading snapshot: $e');
      return false;
    }
  }

  /// Clear all tracked state
  void clear() {
    _stateMap.clear();
    _providerMap.clear();
    _stateHistory.clear();
  }
}

/// Represents a single state change in history
class StateSnapshot {
  final String providerName;
  final DateTime timestamp;
  final dynamic oldValue;
  final dynamic newValue;

  const StateSnapshot({
    required this.providerName,
    required this.timestamp,
    required this.oldValue,
    required this.newValue,
  });

  @override
  String toString() {
    return 'StateSnapshot(provider: $providerName, time: $timestamp, $oldValue -> $newValue)';
  }
}
