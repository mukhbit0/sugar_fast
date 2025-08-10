import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sugar_fast/sugar_fast.dart';

void main() {
  // Initialize Sugar Fast Hub - access to the entire Sugar ecosystem
  SugarFast.initialize(
    devMode: kDebugMode,
  );

  runApp(const ProviderScope(child: SugarExampleApp()));
}

// --- Riverpod Providers (Demonstrating riverpod_sugar) ---
final counterProvider = StateProvider.autoDispose<int>((ref) => 0);
final messageProvider =
    StateProvider.autoDispose<String>((ref) => 'Hello Sugar Fast!');
final userProvider = StateProvider.autoDispose<Map<String, dynamic>>((ref) => {
      'name': 'John Doe',
      'email': 'john@example.com',
    });

// --- Main App Widget ---
class SugarExampleApp extends StatelessWidget {
  const SugarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Standard MaterialApp using `home` for a single-page example.
    return MaterialApp(
      title: 'Sugar Fast Hub - Example',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const SugarHomePage(),
    );
  }
}

// --- Home Page Widget ---

/// The home page of the application, demonstrating riverpod_sugar.
class SugarHomePage extends ConsumerWidget {
  const SugarHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Reading state with riverpod_sugar
    final counter = ref.watch(counterProvider);
    final userName =
        ref.watch(userProvider.select((user) => user['name'] as String));

    return Scaffold(
      appBar: AppBar(
        title: const Text('🚀 Sugar Fast Hub'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome Card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Welcome, $userName!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This app demonstrates features available through the Sugar Fast hub.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Riverpod Sugar Demo Card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '🍰 Riverpod Sugar Demo',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Counter: $counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () =>
                          ref.read(counterProvider.notifier).state++,
                      child: const Text('Increment Counter'),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Hub Status
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade600),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle,
                      color: Colors.green.shade800, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    'Sugar Fast Hub Initialized ✅',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
