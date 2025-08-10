import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_fast/sugar_fast.dart';

void main() {
  // Initialize Sugar Fast
  SugarFast.init(enableDevPanel: true);
  
  runApp(const DebugApp());
}

// Test providers
final counterProvider = StateProvider<int>((ref) => 42);

class DebugApp extends StatelessWidget {
  const DebugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SugarApp(
      child: MaterialApp(
        title: 'Debug Sugar Fast',
        builder: (context, child) => SugarDevOverlay(child: child ?? SizedBox.shrink()),
        home: const DebugPage(),
      ),
    );
  }
}

class DebugPage extends ConsumerWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Sugar Fast')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $counter', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).state++,
              child: const Text('Increment'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final observer = SugarFast.observer;
                if (observer != null) {
                  print('State map: ${observer.stateMap}');
                  print('Provider count: ${observer.stateMap.length}');
                } else {
                  print('Observer is null!');
                }
              },
              child: const Text('Debug Print State'),
            ),
          ],
        ),
      ),
    );
  }
}
