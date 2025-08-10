import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sugar_fast_init.dart';

/// Floating developer panel for live state editing
class SugarDevPanel extends ConsumerStatefulWidget {
  const SugarDevPanel({super.key});

  @override
  ConsumerState<SugarDevPanel> createState() => _SugarDevPanelState();
}

class _SugarDevPanelState extends ConsumerState<SugarDevPanel> {
  bool _isExpanded = false;
  bool _isDragging = false;
  Offset _position = const Offset(20, 100);
  String _searchQuery = '';
  
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!SugarFast.isInitialized || SugarFast.observer == null) {
      return const SizedBox.shrink();
    }

    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanStart: (details) => _isDragging = true,
        onPanUpdate: (details) {
          if (_isDragging) {
            setState(() {
              _position += details.delta;
              // Keep within screen bounds
              final screenSize = MediaQuery.of(context).size;
              _position = Offset(
                _position.dx.clamp(0, screenSize.width - 60),
                _position.dy.clamp(0, screenSize.height - 60),
              );
            });
          }
        },
        onPanEnd: (details) => _isDragging = false,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(_isExpanded ? 12 : 30),
          color: Colors.deepPurple,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _isExpanded ? 350 : 60,
            height: _isExpanded ? 500 : 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_isExpanded ? 12 : 30),
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: _isExpanded ? _buildExpandedPanel() : _buildCollapsedButton(),
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsedButton() {
    return InkWell(
      onTap: () => setState(() => _isExpanded = true),
      borderRadius: BorderRadius.circular(30),
      child: const Center(
        child: Icon(
          Icons.settings,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildExpandedPanel() {
    final observer = SugarFast.observer!;
    final stateEntries = observer.stateMap.entries
        .where((entry) => 
            _searchQuery.isEmpty || 
            entry.key.toLowerCase().contains(_searchQuery))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                '🍭 Sugar Fast',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => setState(() => _isExpanded = false),
                icon: const Icon(Icons.close, color: Colors.white),
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Search bar
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Search providers...',
                hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.white70, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'Save',
                  Icons.save,
                  _saveSnapshot,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionButton(
                  'Load',
                  Icons.upload,
                  _loadSnapshot,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionButton(
                  'Clear',
                  Icons.clear,
                  _clearAll,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // State list
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: stateEntries.isEmpty
                  ? const Center(
                      child: Text(
                        'No providers found',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: stateEntries.length,
                      itemBuilder: (context, index) {
                        final entry = stateEntries[index];
                        return _buildStateItem(entry.key, entry.value);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      height: 32,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        label: Text(label, style: const TextStyle(fontSize: 12)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildStateItem(String providerName, dynamic value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              providerName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _formatValue(value),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () => _editState(providerName, value),
                  icon: const Icon(Icons.edit, color: Colors.white70, size: 16),
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatValue(dynamic value) {
    if (value == null) return 'null';
    if (value is String) return '"$value"';
    if (value is Map || value is List) {
      return jsonEncode(value);
    }
    return value.toString();
  }

  void _editState(String providerName, dynamic currentValue) {
    final controller = TextEditingController(text: _formatValue(currentValue));
    
    showDialog(
      context: context,
      useRootNavigator: true, // Use root navigator to avoid context issues
      builder: (dialogContext) => AlertDialog(
        title: Text('Edit $providerName'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'New Value',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext, rootNavigator: true).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _updateState(providerName, controller.text);
              Navigator.of(dialogContext, rootNavigator: true).pop();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _updateState(String providerName, String newValueText) {
    try {
      dynamic newValue;
      
      // Try to parse as JSON first
      try {
        newValue = jsonDecode(newValueText);
      } catch (_) {
        // If JSON parsing fails, treat as string
        newValue = newValueText;
      }
      
      final success = SugarFast.observer!.setState(providerName, newValue, ref);
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Updated $providerName'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update $providerName'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _saveSnapshot() {
    final snapshot = SugarFast.observer!.saveSnapshot();
    Clipboard.setData(ClipboardData(text: snapshot));
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Snapshot saved to clipboard'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _loadSnapshot() async {
    final clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData?.text == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No data in clipboard'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    final success = SugarFast.observer!.loadSnapshot(clipboardData!.text!, ref);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Snapshot loaded' : 'Failed to load snapshot'),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  void _clearAll() {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear All State'),
        content: const Text('Are you sure you want to clear all tracked state?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext, rootNavigator: true).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              SugarFast.observer!.clear();
              Navigator.of(dialogContext, rootNavigator: true).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All state cleared'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
