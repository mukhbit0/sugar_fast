import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_fast/sugar_fast.dart';

void main() {
  // Initialize Sugar Fast with developer tools
  SugarFast.init(enableDevPanel: true);
  
  runApp(const SimpleTestApp());
}

// Simple test providers
final counterProvider = StateProvider<int>((ref) => 0);
final textProvider = StateProvider<String>((ref) => 'Hello Sugar Fast!');
final colorProvider = StateProvider<Color>((ref) => Colors.blue);

class SimpleTestApp extends StatelessWidget {
  const SimpleTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SugarApp(
      child: SugarMaterialApp(
        title: 'Sugar Fast Test',
        home: const TestHomePage(),
      ),
    );
  }
}

class TestHomePage extends ConsumerWidget {
  const TestHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final text = ref.watch(textProvider);
    final color = ref.watch(colorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🍭 Sugar Fast Test'),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 24, color: color),
            ),
            const SizedBox(height: 20),
            Text(
              'Counter: $counter',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).state++,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
              ),
              child: const Text('Increment'),
            ),
            const SizedBox(height: 20),
            const Text(
              '👆 Tap the floating gear button to edit state live!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
