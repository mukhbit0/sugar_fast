# 🍭 Sugar Fast - Flutter Development Hub

[![pub package](https://img.shields.io/pub/v/sugar_fast.svg)](https://pub.dev/packages/sugar_fast)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-blue.svg)](https://dart.dev)

**Sugar Fast** is a comprehensive meta-package that brings together the entire Sugar ecosystem for super-fast Flutter development. Instead of managing multiple dependencies, install once and get access to everything you need.

## 🎯 **One Package, Everything Included**

```yaml
dependencies:
  sugar_fast: ^2.0.0  # Gets you EVERYTHING
```

```dart
import 'package:sugar_fast/sugar_fast.dart';  // One import for all Sugar features

void main() {
  SugarFast.initialize();
  runApp(MyApp());
}
```

## 🧩 **What's Included**

| Package | Status | Description |
|---------|--------|-------------|
| 🍰 **Riverpod Sugar** | ✅ Available | Enhanced Riverpod utilities and helpers |
| 🧩 **Sugar UI** | 🚧 Coming Soon | Pre-built, customizable widgets |
| 🔗 **Sugar Connect** | 🚧 Coming Soon | HTTP/API utilities and networking |
| 🎨 **Sugar Themer** | 🚧 Coming Soon | Advanced theming and styling system |
| 🍰 **Sugar Slices** | 🚧 Coming Soon | Enhanced Riverpod state management |

## 🚀 **Quick Start**

### 1. Install

```bash
flutter pub add sugar_fast
```

### 2. Initialize

```dart
import 'package:sugar_fast/sugar_fast.dart';
import 'package:flutter/foundation.dart';

void main() {
  SugarFast.initialize(
    devMode: kDebugMode,
  );
  runApp(MyApp());
}
```

### 3. Use Everything

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use Riverpod Sugar (currently available)
    final user = ref.watch(userProvider);
    
    // Coming soon: Use other Sugar packages
    // return SugarCard(child: ...);        // Sugar UI
    // return SugarTheme.dark(child: ...);  // Sugar Themer
    // ApiClient.get('/users');             // Sugar Connect
    
    return Text('Hello ${user.name}');
  }
}
```

## 🎛️ **Individual Packages (Advanced Users)**

Need fine-grained control? Install individual packages:

```yaml
dependencies:
  riverpod_sugar: ^1.0.9     # State management only
  # sugar_ui: ^1.0.0         # UI components only (coming soon)
  # sugar_connect: ^1.0.0    # API utilities only (coming soon)
  # sugar_themer: ^1.0.0     # Theming only (coming soon)
```

## 📚 **Documentation**

- **[Riverpod Sugar Docs](https://pub.dev/packages/riverpod_sugar)** - Available now
- **Sugar UI Docs** - Coming soon
- **Sugar Connect Docs** - Coming soon  
- **Sugar Themer Docs** - Coming soon

## 🗺️ **Development Roadmap**

### Phase 1 - State Management ✅
- [x] Riverpod Sugar integration
- [x] Hub package structure
- [x] Unified initialization

### Phase 2 - UI Components 🚧
- [ ] Sugar UI package
- [ ] Pre-built widgets
- [ ] Customizable components

### Phase 3 - Networking & APIs 🚧
- [ ] Sugar Connect package
- [ ] HTTP utilities
- [ ] API helpers

### Phase 4 - Theming & Design 🚧
- [ ] Sugar Themer package
- [ ] Advanced theming system
- [ ] Design tokens

## 🌟 **Why Use Sugar Fast?**

### **Single Dependency**
Instead of managing multiple packages, add one dependency and get access to the entire Sugar ecosystem.

### **Unified API**
All Sugar packages work together seamlessly with consistent APIs and patterns.

### **Future-Proof**
As new Sugar packages are released, they're automatically included in Sugar Fast updates.

### **Optional Granularity**
Need fine control? You can still install individual packages separately.

## 📦 **Package Details**

### **Current Size**
- **Riverpod Sugar**: Enhanced state management utilities

### **Coming Soon**
- **Sugar UI**: Pre-built, customizable widgets for common use cases
- **Sugar Connect**: HTTP/API utilities with built-in error handling
- **Sugar Themer**: Advanced theming system with design tokens
- **Sugar Slices**: Enhanced Riverpod state management patterns

## 🤝 **Contributing**

We welcome contributions to the Sugar ecosystem! Each package has its own repository:

- **sugar_fast** (this hub): [mukhbit0/sugar_fast](https://github.com/mukhbit0/sugar_fast)
- **riverpod_sugar**: [Contribute here](https://pub.dev/packages/riverpod_sugar)
- More packages coming soon...

### **Contribution Guidelines**
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 **License**

MIT License - see [LICENSE](LICENSE) for details.

## 🔗 **Links**

- [Pub.dev Package](https://pub.dev/packages/sugar_fast)
- [GitHub Repository](https://github.com/mukhbit0/sugar_fast)
- [Issue Tracker](https://github.com/mukhbit0/sugar_fast/issues)
- [Changelog](CHANGELOG.md)

---

<p align="center">
  <strong>Built with ❤️ for the Flutter community</strong><br>
  Making Flutter development faster, one package at a time.
</p>
