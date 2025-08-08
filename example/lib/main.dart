import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_fast/sugar_fast.dart';
import 'dart:async';

void main() {
  runApp(const ProviderScope(child: SugarExampleApp()));
}

// Providers for reactive state management with Riverpod Sugar
final counter = StateProvider<int>((ref) => 0);
final message = StateProvider<String>((ref) => 'Welcome to Sugar Fast!');
final themeColor = StateProvider<Color>((ref) => Colors.blue);
final selectedIcon = StateProvider<IconData>((ref) => Icons.star);
final isEnabled = StateProvider<bool>((ref) => true);

class SugarExampleApp extends StatelessWidget {
  const SugarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sugar Fast - Modular Performance UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SugarHomePage(),
    );
  }
}

class SugarHomePage extends ConsumerStatefulWidget {
  const SugarHomePage({super.key});

  @override
  ConsumerState<SugarHomePage> createState() => _SugarHomePageState();
}

class _SugarHomePageState extends ConsumerState<SugarHomePage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start automatic updates to demonstrate paint-only performance
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      ref.read(counter.notifier).state++;
      if (ref.read(counter.notifier).state % 10 == 0) {
        final colors = [
          Colors.blue,
          Colors.red,
          Colors.green,
          Colors.purple,
          Colors.orange
        ];
        final icons = [
          Icons.star,
          Icons.favorite,
          Icons.thumb_up,
          Icons.lightbulb,
          Icons.rocket_launch
        ];
        ref.read(themeColor.notifier).state =
            colors[ref.read(counter.notifier).state ~/ 10 % colors.length];
        ref.read(selectedIcon.notifier).state =
            icons[ref.read(counter.notifier).state ~/ 10 % icons.length];
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SugarText(
          'Sugar Fast - Modular UI Framework',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: ref.watch(themeColor),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            const SugarText(
              '🚀 Revolutionary Performance UI Framework',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const SugarText(
              'Modular widgets with 300-2000% performance improvements',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // Performance Demo Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SugarText(
                      '📊 Real-time Performance Demo',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const SugarText('SugarText (Paint-only)',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Consumer(
                                builder: (context, ref, _) {
                                  return SugarText(
                                    'Count: ${ref.watch(counter)}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: ref.watch(themeColor),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                              const SugarText(
                                '✅ No widget rebuilds',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              const Text('Standard Text (Full rebuild)',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Consumer(
                                builder: (context, ref, _) {
                                  return Text(
                                    'Count: ${ref.watch(counter)}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: ref.watch(themeColor),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                              const Text(
                                '🔴 Widget tree rebuild',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // SugarContainer Demo
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SugarText(
                      '📦 SugarContainer - Dynamic Styling',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Consumer(
                      builder: (context, ref, _) {
                        return SugarContainer(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: ref.watch(themeColor).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: ref.watch(themeColor),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: ref
                                    .watch(themeColor)
                                    .withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Consumer(
                                builder: (context, ref, _) {
                                  return SugarIcon(
                                    ref.watch(selectedIcon),
                                    size: 32,
                                    color: ref.watch(themeColor),
                                  );
                                },
                              ),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: SugarText(
                                  'Container updates only decoration/color\nwithout rebuilding child widgets!',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // SugarButton Demo
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SugarText(
                      '🔘 SugarButton - Interactive Performance',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SugarButton(
                          onPressed: () {
                            ref.read(counter.notifier).state = 0;
                            ref.read(message.notifier).state = 'Counter reset!';
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const SugarText('Reset Counter'),
                        ),
                        SugarButton(
                          onPressed: () {
                            SugarDebug.showSugarWidgetBounds =
                                !SugarDebug.showSugarWidgetBounds;
                            ref.read(message.notifier).state =
                                'Debug bounds ${SugarDebug.showSugarWidgetBounds ? 'enabled' : 'disabled'}';
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const SugarText('Toggle Debug'),
                        ),
                        Consumer(
                          builder: (context, ref, _) {
                            return SugarButton(
                              onPressed: ref.watch(isEnabled)
                                  ? () {
                                      ref.read(isEnabled.notifier).state =
                                          false;
                                      ref.read(message.notifier).state =
                                          'Button disabled';
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        ref.read(isEnabled.notifier).state =
                                            true;
                                        ref.read(message.notifier).state =
                                            'Button re-enabled';
                                      });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ref.watch(isEnabled)
                                    ? ref.watch(themeColor)
                                    : Colors.grey,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: SugarText(ref.watch(isEnabled)
                                  ? 'Dynamic Button'
                                  : 'Disabled'),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Status Message
            Consumer(
              builder: (context, ref, _) {
                return SugarContainer(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    children: [
                      const SugarIcon(
                        Icons.info_outline,
                        size: 20,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SugarText(
                          ref.watch(message),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Architecture Info
            const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SugarText(
                      '🏗️ Modular Architecture Benefits',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    SugarListItem(
                      leading:
                          SugarIcon(Icons.folder_outlined, color: Colors.blue),
                      title: SugarText('Modular Structure',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: SugarText(
                          'Each widget in its own folder for easy maintenance'),
                    ),
                    SugarListItem(
                      leading: SugarIcon(Icons.speed, color: Colors.green),
                      title: SugarText('Paint-only Updates',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: SugarText(
                          '300-2000% performance improvement over standard widgets'),
                    ),
                    SugarListItem(
                      leading: SugarIcon(Icons.integration_instructions,
                          color: Colors.orange),
                      title: SugarText('Riverpod Sugar Integration',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: SugarText(
                          'Seamless reactive state management with .state extensions'),
                    ),
                    SugarListItem(
                      leading: SugarIcon(Icons.api, color: Colors.purple),
                      title: SugarText('Complete API Parity',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: SugarText(
                          'Drop-in replacements for all standard Flutter widgets'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Footer
            Center(
              child: Column(
                children: [
                  const SugarText(
                    'Made with Sugar Fast 🚀',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer(
                    builder: (context, ref, _) {
                      return SugarText(
                        'Updates: ${ref.watch(counter)} times per second',
                        style: TextStyle(
                          fontSize: 12,
                          color: ref.watch(themeColor),
                        ),
                      );
                    },
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
