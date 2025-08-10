# 🍭 Sugar Fast: Quick Setup Guide

## 🚀 **Two Ways to Add Sugar Fast to Your App**

### **Option 1: Drop-in Replacement (Easiest)**

Replace your `MaterialApp` with `SugarMaterialApp`:

```dart
import 'package:sugar_fast/sugar_fast.dart';

void main() {
  SugarFast.init();  // Initialize Sugar Fast
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SugarApp(
      child: SugarMaterialApp(  // 🍭 Use this instead of MaterialApp
        title: 'My App',
        home: HomePage(),
        // ... all your normal MaterialApp properties
      ),
    );
  }
}
```

### **Option 2: Manual Integration (More Control)**

Keep your existing `MaterialApp` and add the dev overlay manually:

```dart
import 'package:sugar_fast/sugar_fast.dart';

void main() {
  SugarFast.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SugarApp(
      child: MaterialApp(
        title: 'My App',
        builder: (context, child) {
          return SugarDevOverlay(  // 🍭 Add this wrapper
            child: child ?? SizedBox.shrink(),
          );
        },
        home: HomePage(),
      ),
    );
  }
}
```

### **Option 3: Minimal Setup (Just Providers)**

If you only want state tracking without the UI panel:

```dart
import 'package:sugar_fast/sugar_fast.dart';

void main() {
  SugarFast.init(enableDevPanel: false);  // Disable UI panel
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SugarApp(  // Still get state tracking
      child: MaterialApp(
        title: 'My App',
        home: HomePage(),
      ),
    );
  }
}
```

## 🎯 **That's It!**

- **Floating gear button** appears in debug mode
- **Tap it** to open the Sugar Fast dev panel
- **Edit any provider state** in real-time
- **Save/load snapshots** for testing scenarios

## 🛡️ **Production Safety**

Sugar Fast automatically:
- ✅ **Disables in release builds** (no performance impact)
- ✅ **Only shows in debug mode** (kDebugMode check)
- ✅ **Zero overhead** when disabled

Ready to revolutionize your Flutter debugging! 🍭⚡
