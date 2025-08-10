import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_fast/sugar_fast.dart';

void main() {
  // Initialize Sugar Fast with developer tools
  SugarFast.init(enableDevPanel: true);
  
  runApp(const SugarExampleApp());
}

// Sample providers to demonstrate live state editing
final counterProvider = StateProvider.autoDispose<int>((ref) => 0);
final messageProvider = StateProvider.autoDispose<String>((ref) => 'Hello Sugar Fast!');
final colorProvider = StateProvider.autoDispose<Color>((ref) => Colors.blue);
final enabledProvider = StateProvider.autoDispose<bool>((ref) => true);

// More complex state for advanced editing
final userProvider = StateProvider.autoDispose<Map<String, dynamic>>((ref) => {
  'name': 'John Doe',
  'email': 'john@example.com',
  'age': 25,
  'premium': false,
});

final settingsProvider = StateProvider.autoDispose<AppSettings>((ref) => AppSettings(
  darkMode: false,
  notifications: true,
  fontSize: 16.0,
));

class AppSettings {
  final bool darkMode;
  final bool notifications;
  final double fontSize;

  AppSettings({
    required this.darkMode,
    required this.notifications,
    required this.fontSize,
  });

  @override
  String toString() {
    return 'AppSettings(darkMode: $darkMode, notifications: $notifications, fontSize: $fontSize)';
  }
}

class SugarExampleApp extends StatelessWidget {
  const SugarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SugarApp(
      child: SugarMaterialApp(
        title: 'Sugar Fast - Live State Editing Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SugarHomePage(),
      ),
    );
  }
}

class SugarHomePage extends ConsumerWidget {
  const SugarHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final message = ref.watch(messageProvider);
    final color = ref.watch(colorProvider);
    final enabled = ref.watch(enabledProvider);
    final user = ref.watch(userProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: color.withValues(alpha: 0.1),
      appBar: AppBar(
        title: const Text('🍭 Sugar Fast Demo'),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Instructions Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🎯 Live State Editing Demo',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap the floating gear button to open the Sugar Fast dev panel and edit state in real-time!',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Try editing: counter, message, color, enabled, user data, or settings',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Counter Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.add_circle, color: color, size: 32),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Counter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('$counter', style: TextStyle(fontSize: 24, color: color)),
                      ],
                    ),
                    const Spacer(),
                    FloatingActionButton.small(
                      onPressed: enabled ? () => ref.read(counterProvider.notifier).state++ : null,
                      backgroundColor: enabled ? color : Colors.grey,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Message Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.message, color: color, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Message', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(message, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // User Info Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: color, size: 32),
                        const SizedBox(width: 16),
                        const Text('User Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Name: ${user['name']}'),
                    Text('Email: ${user['email']}'),
                    Text('Age: ${user['age']}'),
                    Text('Premium: ${user['premium']}'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Settings Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings, color: color, size: 32),
                        const SizedBox(width: 16),
                        const Text('App Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Dark Mode: ${settings.darkMode}'),
                    Text('Notifications: ${settings.notifications}'),
                    Text('Font Size: ${settings.fontSize}'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: enabled
                        ? () => ref.read(counterProvider.notifier).state = 0
                        : null,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Counter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref.read(enabledProvider.notifier).state = !enabled;
                    },
                    icon: Icon(enabled ? Icons.pause : Icons.play_arrow),
                    label: Text(enabled ? 'Disable' : 'Enable'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: enabled ? Colors.orange : Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}
