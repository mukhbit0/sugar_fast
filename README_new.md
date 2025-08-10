# 🍭 Sugar Fast: Live State Editing

[![pub package](https://img.shields.io/pub/v/sugar_fast.svg)](https://pub.dev/packages/sugar_fast)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-blue.svg)](https://dart.dev)

**🔥 Revolutionary Flutter Developer Tooling: Real-time State Editing & Debugging!**

Transform your Flutter development workflow with **live state editing**, **scenario testing**, and **time-travel debugging** for Riverpod applications. No more `print` statements or rebuilding to test different states!

## 🌟 **Why Sugar Fast Will Change Your Development**

### **The Problem with Traditional Flutter Debugging**
- **Manual state setup** for testing different scenarios 📉
- **Endless rebuilds** to test edge cases ⚠️  
- **Print-based debugging** that clutters your code 🐌
- **No way to share exact app states** with teammates 💾

### **The Sugar Fast Solution**
- **Edit state in real-time** without code changes ⚡
- **Save and load state scenarios** for instant testing 🎨
- **Share exact bug states** with your team 🚫🔄
- **Time-travel through state changes** for debugging 🏗️

## 🎯 **Live State Editing Features**

### **📱 In-App Developer Panel**

- **🎚️ Real-time State Editor** - Edit any Riverpod provider value instantly
- **🔍 Smart Search** - Find providers by name or type quickly
- **💾 State Snapshots** - Save/load complete app states
- **📋 One-click Sharing** - Copy state to clipboard for team sharing
- **🎯 Type-safe Editing** - Handles strings, numbers, booleans, maps, and lists

### **🛠️ Advanced Developer Tools**

- **⏱️ State History** - Track all state changes with timestamps
- **🔎 Provider Analytics** - See which providers update most frequently
- **📊 State Validation** - Detect non-serializable or problematic states
- **🧪 Scenario Testing** - Create named test scenarios for common use cases

## 🚀 **Quick Start**

### **1. Installation**

```yaml
dependencies:
  sugar_fast: ^2.0.0
  flutter_riverpod: ^2.4.9
```

### **2. Initialize Sugar Fast**

```dart
import 'package:sugar_fast/sugar_fast.dart';

void main() {
  // Initialize Sugar Fast (automatically enabled in debug mode only)
  SugarFast.init(enableDevPanel: true);
  
  runApp(MyApp());
}
```

### **3. Wrap Your App**

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SugarApp(  // 🍭 Sugar Fast wrapper
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
```

### **4. Start Editing State Live! 🎉**

1. Run your app in debug mode
2. Look for the **floating purple gear button** 🟣
3. Tap it to open the **Sugar Fast dev panel**
4. **Edit any provider state in real-time!**

## 🎮 **Usage Examples**

### **Basic State Editing**

```dart
// Your providers (no changes needed!)
final counterProvider = StateProvider<int>((ref) => 0);
final messageProvider = StateProvider<String>((ref) => 'Hello World');
final userProvider = StateProvider<User>((ref) => User());

// Sugar Fast automatically tracks these providers
// Edit them live in the dev panel! 🎯
```

### **Complex State Scenarios**

```dart
// Create complex test scenarios
final userProvider = StateProvider<Map<String, dynamic>>((ref) => {
  'name': 'John Doe',
  'email': 'john@example.com',
  'isPremium': false,
  'settings': {
    'darkMode': true,
    'notifications': false,
  }
});

// Test different user scenarios instantly:
// - Premium vs Free user
// - Different settings combinations
// - Edge cases like empty names
// All without changing code! 🔥
```

### **Sharing Bug States**

```dart
// When you find a bug:
// 1. Tap "Save" in Sugar Fast panel
// 2. State is copied to clipboard as JSON
// 3. Share with teammate
// 4. They load it with "Load" button
// 5. Bug reproduced instantly! 🐛➜✅
```

## 🏗️ **Advanced Features**

### **State Scenarios for Testing**

```dart
// Save named scenarios programmatically
final scenario = SugarStateManager.createScenario(
  'Premium User Bug',
  description: 'User with premium account seeing free content',
);

// Apply scenarios in tests
SugarStateManager.applyScenario(scenario, ref);
```

### **Provider Analytics**

```dart
// Get insights about your state
final summary = SugarStateManager.getStateSummary();
print('Providers: ${summary.providerCount}');
print('Last update: ${summary.lastUpdateTime}');

// Find specific provider types
final stringProviders = SugarStateManager.findProvidersByType<String>();
```

### **State Validation**

```dart
// Check for problematic state
final issues = SugarStateManager.validateState();
if (issues.isNotEmpty) {
  print('State issues found: $issues');
}
```

## 🎯 **Perfect for These Use Cases**

- **🐛 Bug Reproduction** - Save exact state when bug occurs, share with team
- **🧪 Feature Testing** - Test edge cases without manual setup
- **📱 UI Development** - See how UI responds to different data instantly
- **🔄 State Debugging** - Track exactly how state changes over time
- **👥 Team Collaboration** - Share complex app states effortlessly
- **🚀 QA Testing** - Create test scenarios that mimic production data

## 🛡️ **Production Safety**

- **Debug-only by default** - Automatically disabled in release builds
- **Zero performance impact** in production
- **No code changes required** for existing Riverpod apps
- **Optional initialization** - Works with existing ProviderScope setups

## 🌐 **Supported Provider Types**

| Provider Type | Live Editing | Notes |
|---------------|--------------|-------|
| `StateProvider` | ✅ Full Support | All value types |
| `StateNotifierProvider` | 🔄 Coming Soon | Complex state objects |
| `FutureProvider` | 👀 Read-only | View async states |
| `StreamProvider` | 👀 Read-only | Monitor stream values |
| Custom Providers | 👀 Read-only | Display current value |

## 🚧 **Coming Soon (Phase 2)**

- **🌐 External Browser Panel** - Control from separate web interface
- **⏰ Time Travel Debugging** - Scrub through state history
- **🔄 Auto-save Scenarios** - Automatically save interesting states
- **📈 Performance Metrics** - Track provider update performance
- **🌍 Multi-app Support** - Debug multiple Flutter apps simultaneously

## 🤝 **Contributing**

We welcome contributions! This tool can revolutionize Flutter development, and we need your help to make it amazing.

### **Ideas for Contributors:**
- Support for more state management libraries (Bloc, Provider, GetX)
- Enhanced UI for the dev panel
- Integration with existing developer tools
- Performance optimizations
- More state serialization formats

## 📝 **Migration from 1.x**

Sugar Fast 2.0 is a complete rewrite focused on developer tooling. If you were using 1.x widgets:

```dart
// 1.x (widgets)
SugarText('Hello')

// 2.x (use regular Flutter widgets + state editing)
Text('Hello')  // Edit the text state live in Sugar Fast panel!
```

## 📜 **License**

MIT License - see [LICENSE](LICENSE) file for details.

---

## 💡 **Why "Sugar Fast"?**

- **🍭 Sweet** - Makes development delightful
- **⚡ Fast** - Instant state changes without rebuilds
- **🎯 Simple** - Zero-config setup for most use cases

**Transform your Flutter debugging workflow today!** 

*No more `print` statements. No more manual state setup. Just pure, sweet, fast state editing.* 🍭⚡

---

Made with ❤️ for the Flutter community
